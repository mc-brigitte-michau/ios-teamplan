import Foundation
import Models

public struct MockCVService: CVService {
    public var candidatesToReturn: [Candidate] = []
    public var candidateToReturn: Candidate?
    public var createdCandidate: Candidate?
    public var updatedCandidate: Candidate?

    public var deleteID: String?

    public var fetchCVsError: HTTPClientError?
    public var fetchVCError: HTTPClientError?
    public var createError: HTTPClientError?
    public var updateError: HTTPClientError?
    public var deleteError: HTTPClientError?
    public var getImageError: HTTPClientError?

    public init() {}

    public func fetchCVs() async throws -> [Candidate] {
        if let fetchCVsError { throw fetchCVsError }
        return candidatesToReturn
    }

    public func fetchVC(id: String) async throws -> Candidate? {
        if let fetchVCError { throw fetchVCError }
        return candidateToReturn
    }

    public func create(resume: CreateResume) async throws -> Candidate? {
        if let createError { throw createError }
        return createdCandidate
    }

    public func update(resume: Candidate) async throws -> Candidate? {
        if let updateError { throw updateError }

        return updatedCandidate
    }

    @discardableResult
    public func delete(id: String) async throws -> Empty {
        if let deleteError { throw deleteError }
        if deleteID == id {
            return Empty()
        } else {
            throw HTTPClientError.generalError
        }
    }

    public func getImage(id: String) async throws -> URL? {
        if let getImageError { throw getImageError }
        return nil
    }
}
