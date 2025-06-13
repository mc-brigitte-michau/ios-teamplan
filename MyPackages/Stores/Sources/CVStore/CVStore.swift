import Foundation
import Models
import Services
import SharedStore

@MainActor
public protocol CVStoreProtocol: AnyObject, ObservableObject {
    var candidates: [Candidate] { get set }
    var myResume: Candidate? { get set }
    var currentCandidate: Candidate? { get set }
    var currentResume: Resume? { get set }

    var listLoadState: LoadState { get set }
    var resumeLoadState: LoadState { get set }
    var createUpdateLoadState: LoadState { get set }

    func fetchResumes() async throws
    func fetchResume(for id: String) async throws
    func createResume(resume: CreateResume) async throws
}

public class CVStore: CVStoreProtocol, @unchecked Sendable {
    @Published public var candidates: [Candidate] = []
    @Published public var myResume: Candidate?
    @Published public var currentCandidate: Candidate?
    @Published public var currentResume: Resume?

    @Published public var listLoadState: LoadState = .idle
    @Published public var resumeLoadState: LoadState = .idle
    @Published public var createUpdateLoadState: LoadState = .idle

    private let service: CVService

    public init(service: CVService) {
        self.service = service
    }

    public func fetchResumes() async throws {
        listLoadState = .loading
        do {
            let result = try await service.fetchCVs()
            candidates = Self.indexCandidates(result)
            myResume = candidates.first
            // https://v2.teamplan.io/my-resume/anneli.mutso@gmail.com
            // @brigitte find out how this should work
            if result.isEmpty {
                listLoadState = .empty
            } else {
                listLoadState = .loaded
            }
        } catch {
            if let clientError = error as? HTTPClientError {
                listLoadState = .failed(clientError.displayMessage)
            } else {
                listLoadState = .failed(error.localizedDescription)
            }
        }
    }

    public func fetchResume(for id: String) async throws {
        resumeLoadState = .loading
        let result = try await service.fetchVC(id: id)
        currentCandidate = result
        resumeLoadState = .loaded
    }

    public func createResume(resume: CreateResume) async throws {
        createUpdateLoadState = .loading
        let result = try await service.create(resume: resume)
        currentCandidate = result
        createUpdateLoadState = .loaded
    }

    public func updateResume(resume: Candidate) async throws {
        createUpdateLoadState = .loading
        let result = try await service.update(resume: resume)
        currentCandidate = result
        createUpdateLoadState = .loaded
    }

    public func deleteResume(for id: String) async throws {
        createUpdateLoadState = .loading
        _ = try await service.delete(id: id)
    }
}

extension CVStore {
    static func indexCandidates(_ candidates: [Candidate]) -> [Candidate] {
        candidates.map { candidate in
            var updated = candidate
            updated.searchIndex = generateSearchIndex(for: candidate)
            return updated
        }
    }

    static func generateSearchIndex(for candidate: Candidate) -> String {
        let skillsText = candidate.resumes
            .flatMap { resume in
                resume.skills.data
                    .flatMap { $0.details.map(\.label) }
            }
            .joined(separator: " ")
        let techsText = candidate.resumes
            .flatMap { resume in
                resume.projects.data
                    .flatMap { $0.technologies.map(\.label) }
            }
            .joined(separator: " ")
        return "\(candidate.fullName) \(skillsText) \(techsText)".lowercased()
    }
}
