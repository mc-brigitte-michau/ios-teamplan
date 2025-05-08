import Foundation
import Networking
import Models

@MainActor
public protocol CVStoreProtocol: AnyObject, ObservableObject {
    var candidates: [Candidate] { get set }
    var myResume: Candidate? { get set }
    var selected: Resume? { get set }
    func fetchResumes() async throws

}

public class CVStore: CVStoreProtocol, @unchecked Sendable {

    @Published public var candidates: [Candidate] = []
    @Published public var myResume: Candidate? = nil
    @Published public var selected: Resume? = nil

    private let service: CVService

    public func fetchResumes() async throws {
        let result = try await service.fetchCVs()
        candidates = CVStore.indexCandidates(result)
        myResume = candidates.first
        // https://v2.teamplan.io/my-resume/anneli.mutso@gmail.com

        // @brigitte find out how this should work
    }

    public init(service: CVService) {
        self.service = service
    }
}

private extension CVStore {
    static func indexCandidates(_ candidates: [Candidate]) -> [Candidate] {
        candidates.map { candidate in
            var updated = candidate
            updated.searchIndex = generateSearchIndex(for: candidate)
            return updated
        }
    }

    static func generateSearchIndex(for candidate: Candidate) -> String {
        let skillsText = candidate.resumes?.flatMap {
            $0.skills.data.flatMap { $0.details.map { $0.label } }
        }.joined(separator: " ")
        let techsText = candidate.resumes?.flatMap {
            $0.projects.data.flatMap { $0.technologies.map { $0.label } }
        }.joined(separator: " ")
        return "\(candidate.fullName) \(skillsText ?? "") \(techsText ?? "")".lowercased()
    }
}

extension CVStore {

    public static var preview: CVStore {
        let store = CVStore(service: DummyCVService())
        store.candidates = indexCandidates([.mock])
        store.myResume = .mock
        store.selected = nil
        return store
    }

    public static var previewEmpty: CVStore {
        let store = CVStore(service: DummyCVService())
        store.candidates = []
        store.selected = nil
        store.myResume = nil
        return store
    }
}
