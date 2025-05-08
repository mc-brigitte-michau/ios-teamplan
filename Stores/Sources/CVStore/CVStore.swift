import Foundation
import Networking
import Models

@MainActor
public protocol CVStoreProtocol: AnyObject, ObservableObject {
    var candidates: [Candidate] { get set }
    var myResume: Candidate? { get set }
    var selected: Resume? { get set }
    func fetchCVs() async throws
    func fetchVC(id: String) async throws -> Candidate?
    func create(resume: Candidate) async throws -> Candidate?
    func update(resume: Candidate) async throws -> Candidate?
    func delete(id: String) async throws
    func getImage(id: String) async throws -> URL?
}

public class CVStore: CVStoreProtocol {

    @Published public var candidates: [Candidate] = []
    @Published public var myResume: Candidate? = nil
    @Published public var selected: Resume? = nil

    private let httpClient: HTTPClient

    public init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    public func fetchCVs() async throws {
        candidates = CVStore.indexCandidates([.mock])
        myResume = .mock
        selected = nil
    }

    public func fetchVC(id: String) async throws -> Candidate? {
        .mock
    }

    public func create(resume: Candidate) async throws -> Candidate? {
        .mock
    }

    public func update(resume: Candidate) async throws -> Candidate? {
        fatalError("not implemented")
    }

    public func delete(id: String) async throws {
        fatalError("not implemented")
    }

    public func getImage(id: String) async throws -> URL? {
        fatalError("not implemented")
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
        let skillsText = candidate.resumes.flatMap {
            $0.skills.data.flatMap { $0.details.map { $0.label } }
        }.joined(separator: " ")
        let techsText = candidate.resumes.flatMap {
            $0.projects.data.flatMap { $0.technologies.map { $0.label } }
        }.joined(separator: " ")
        return "\(candidate.fullName) \(skillsText) \(techsText)".lowercased()
    }
}

extension CVStore {

    public static var preview: CVStore {
        let store = CVStore(httpClient: DummyHTTPClient())
        store.candidates = indexCandidates([.mock])
        store.myResume = .mock
        store.selected = nil
        return store
    }

    public static var previewEmpty: CVStore {
        let store = CVStore(httpClient: DummyHTTPClient())
        store.candidates = []
        store.selected = nil
        store.myResume = nil
        return store
    }
}
