import Foundation
import Models

public protocol APIRequest {
    associatedtype Response: Decodable
    associatedtype Body: Encodable

    var endpoint: String { get }
    var method: String { get }
    var pathParameters: [String: String] { get }
    var queryParameters: [String: String] { get }
    var body: Body? { get }
}

public  extension APIRequest {
    var bodyData: Data? {
        guard let body = body else { return nil }
        return try? JSONEncoder().encode(body)
    }
}

public struct Empty: Codable {}

/// Gets a list of all CVs
public struct ListCVsRequest: APIRequest {
    public typealias Response = [Candidate]
    public typealias Body = Empty

    public let endpoint = "/cv"
    public let method = "GET"
    public let pathParameters: [String: String] = [:]
    public let queryParameters: [String: String] = [:]
    public let body: Body? = nil
}

/// Gets one single CV
public struct ListCVRequest: APIRequest {
    public typealias Response = Candidate
    public typealias Body = Empty

    public var endpoint: String { "/cv/{id}" }
    public let method = "GET"
    public var pathParameters: [String: String] { ["id": id] }
    public let queryParameters: [String: String] = [:]
    public let body: Body? = nil
    public let id: String

    public init(id: String) {
        self.id = id
    }
}

/// Create new CV
public struct CreateCVRequest: APIRequest {
    public typealias Response = Candidate
    public typealias Body = Resume

    public let endpoint = "/cv"
    public let method = "POST"
    public let pathParameters: [String: String] = [:]
    public let queryParameters: [String: String] = [:]
    public let body: Body?

    public init(resume: Resume) {
        self.body = resume
    }
}

// Update a CV
public struct UpdateCVRequest: APIRequest {
    public typealias Response = Candidate
    public typealias Body = Resume

    public let endpoint = "/cv/{id}"
    public let method = "PUT"
    public var pathParameters: [String: String] { ["id": id] }
    public let queryParameters: [String: String] = [:]
    public let body: Body?
    public let id: String

    public init(id: String, resume: Resume) {
        self.id = id
        self.body = resume
    }
}

// Delete a CV
public struct DeleteCVRequest: APIRequest {
    public typealias Response = Empty
    public typealias Body = Empty

    public let endpoint = "/cv/{id}"
    public let method = "DELETE"
    public var pathParameters: [String: String] { ["id": id] }
    public let queryParameters: [String: String] = [:]
    public let body: Body? = nil
    public let id: String

    public init(id: String) {
        self.id = id
    }
}

/// Get image for a CV /api/files/{cv_id}
public struct GetCVImageRequest: APIRequest {
    public typealias Response = UploadResponse
    public typealias Body = Empty
    public let cvID: String
    public var endpoint: String { "/api/files/{cv_id}" }
    public let method = "GET"
    public var pathParameters: [String: String] { ["cv_id": cvID] }
    public let queryParameters: [String: String] = [:]
    public let body: Body? = nil
}

