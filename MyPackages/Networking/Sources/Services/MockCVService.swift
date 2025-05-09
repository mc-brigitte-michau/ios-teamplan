import Models
import Foundation

public struct MockCVService: CVService {

    public var candidatesToReturn: [Candidate] = []

    public init() {}

    public func fetchCVs() async throws -> [Candidate] {
        candidatesToReturn
    }

    public func fetchVC(id: String) async throws -> Candidate? {
        .mock
    }

    public func create(resume: Candidate) async throws -> Candidate? {
        .mock
    }

    public func update(resume: Candidate) async throws -> Candidate? {
        .mock
    }

    public func delete(id: String) async throws {

    }

    public func getImage(id: String) async throws -> URL? {
        nil
    }
}
