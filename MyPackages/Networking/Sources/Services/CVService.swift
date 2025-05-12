import Models
import Foundation
import Client
import Requests

public protocol CVService: Sendable {
    func fetchCVs() async throws -> [Candidate]
    func fetchVC(id: String) async throws -> Candidate?
    func create(resume: CreateResume) async throws -> Candidate?
    func update(resume: Candidate) async throws -> Candidate?
    @discardableResult
    func delete(id: String) async throws -> Empty
    func getImage(id: String) async throws -> URL?
}

public actor CVServiceImpl: CVService {

    private let httpClient: HTTPClient & Sendable

    public init(httpClient: HTTPClient & Sendable) {
        self.httpClient = httpClient
    }

    public func fetchCVs() async throws -> [Candidate] {
        let request = ListCVsRequest()
        return try await httpClient.send(request: request)
    }

    public func fetchVC(id: String) async throws -> Candidate? {
        let request = ListCVRequest(id: id)
        return try await httpClient.send(request: request)
    }

    public func create(resume: CreateResume) async throws -> Candidate? {
        let request = CreateCVRequest(resume: resume)
        return try await httpClient.send(request: request)
    }

    public func update(resume: Candidate) async throws -> Candidate? {
        let request = UpdateCVRequest(resume: resume)
        return try await httpClient.send(request: request)
    }

    @discardableResult
    public func delete(id: String) async throws -> Empty {
        let request = DeleteCVRequest(id: id)
        return try await httpClient.send(request: request)
    }

    public func getImage(id: String) async throws -> URL? {
        fatalError("not implemented")
    }
}



