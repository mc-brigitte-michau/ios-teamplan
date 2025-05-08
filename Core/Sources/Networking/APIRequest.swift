import Foundation
import Models

protocol APIRequest {
    associatedtype Response: Decodable
    associatedtype Body: Encodable

    var endpoint: String { get }
    var method: String { get }
    var pathParameters: [String: String] { get }
    var queryParameters: [String: String] { get }
    var body: Body? { get }
}

extension APIRequest {
    func urlString(baseURL: String) -> String {
        var path = endpoint
        for (key, value) in pathParameters {
            path = path.replacingOccurrences(of: "{\(key)}", with: value)
        }
        var url = baseURL + path
        if !queryParameters.isEmpty {
            let query = queryParameters
                .map { "\($0.key)=\($0.value)" }
                .joined(separator: "&")
            url += "?\(query)"
        }
        return url
    }
}

extension APIRequest {
    var bodyData: Data? {
        guard let body = body else { return nil }
        return try? JSONEncoder().encode(body)
    }
}

struct Empty: Codable {}


/// Gets a list of all CVs
struct ListCVsRequest: APIRequest {
    typealias Response = Resumes
    typealias Body = Empty

    let endpoint = "/cv"
    let method = "GET"
    let pathParameters: [String: String] = [:]
    let queryParameters: [String: String] = [:]
    let body: Body? = nil
}

/// Gets one single CV
struct ListCVRequest: APIRequest {
    typealias Response = Resumes
    typealias Body = Empty

    var endpoint: String { "/cv/{id}" }
    let method = "GET"
    var pathParameters: [String: String] { ["id": id] }
    let queryParameters: [String: String] = [:]
    let body: Body? = nil
    let id: String

    init(id: String) {
        self.id = id
    }
}

/// Create new CV
struct CreateCVRequest: APIRequest {
    typealias Response = Resumes
    typealias Body = Resume

    let endpoint = "/cv"
    let method = "POST"
    let pathParameters: [String: String] = [:]
    let queryParameters: [String: String] = [:]
    let body: Body?

    init(resume: Resume) {
        self.body = resume
    }
}

// Update a CV
struct UpdateCVRequest: APIRequest {
    typealias Response = Resumes
    typealias Body = Resume

    let endpoint = "/cv/{id}"
    let method = "PUT"
    var pathParameters: [String: String] { ["id": id] }
    let queryParameters: [String: String] = [:]
    let body: Body?
    let id: String

    init(id: String, resume: Resume) {
        self.id = id
        self.body = resume
    }
}

// Delete a CV
struct DeleteCVRequest: APIRequest {
    typealias Response = Empty
    typealias Body = Empty

    let endpoint = "/cv/{id}"
    let method = "DELETE"
    var pathParameters: [String: String] { ["id": id] }
    let queryParameters: [String: String] = [:]
    let body: Body? = nil
    let id: String

    init(id: String) {
        self.id = id
    }
}

/// Get image for a CV /api/files/{cv_id}
struct GetCVImageRequest: APIRequest {
    typealias Response = UploadResponse
    typealias Body = Empty
    let cvID: String
    var endpoint: String { "/api/files/{cv_id}" }
    let method = "GET"
    var pathParameters: [String: String] { ["cv_id": cvID] }
    let queryParameters: [String: String] = [:]
    let body: Body? = nil
}

