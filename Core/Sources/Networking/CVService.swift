import Models
import Foundation

public protocol CVService: Sendable {
    func fetchCVs() async throws -> [Candidate]
    func fetchVC(id: String) async throws -> Candidate?
    func create(resume: Candidate) async throws -> Candidate?
    func update(resume: Candidate) async throws -> Candidate?
    func delete(id: String) async throws
    func getImage(id: String) async throws -> URL?
}

public actor CVServiceImpl: CVService {

    private let httpClient: HTTPClient & Sendable

        public init(httpClient: HTTPClient & Sendable) {
            self.httpClient = httpClient
        }

    public func fetchCVs() async throws -> [Candidate] {
        let request = ListCVsRequest()
        let response: [Candidate] = try await httpClient.send(request)
        return response
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


public struct DummyCVService: CVService {

    public init() {}

    public func fetchCVs() async throws -> [Candidate] {
        [.mock]
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
