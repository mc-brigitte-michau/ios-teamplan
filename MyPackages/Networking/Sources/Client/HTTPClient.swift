import Foundation
import Models
import Requests

public protocol HTTPClient {
    func send<T: APIRequest>(_ request: T) async throws -> T.Response where T.Response: Sendable
    func send<T: MultipartAPIRequest>(_ request: T) async throws -> T.Response where T.Response: Sendable
}

public actor HTTPClientImpl: HTTPClient, @unchecked Sendable {
    private let session: URLSession
    private let baseURL: String

    public init(baseURL: String, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }

    public func send<T: APIRequest>(_ request: T) async throws -> T.Response where T.Response: Sendable  {
        let urlRequest = try buildRequest(request)
        let (data, response) = try await session.data(for: urlRequest)
        try validateResponse(data, response: response)
        return try JSONDecoder().decode(T.Response.self, from: data)
    }

    public func send<T: MultipartAPIRequest>(_ request: T) async throws -> T.Response where T.Response: Sendable {
        let urlRequest = buildMultipartRequest(request)
        let (data, response) = try await session.data(for: urlRequest)
        try validateResponse(data, response: response)
        return try JSONDecoder().decode(T.Response.self, from: data)
    }

    func validateResponse(_ data: Data?, response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HTTPClientError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            let responseText = data.flatMap { String(data: $0, encoding: .utf8) } ?? "No response body"
            throw HTTPClientError.httpError(statusCode: httpResponse.statusCode, body: responseText)
        }
    }
}

extension HTTPClientImpl {

    func buildRequest(_ request: some APIRequest) throws -> URLRequest {
        var path = request.endpoint
        for (key, value) in request.pathParameters {
            path = path.replacingOccurrences(of: "{\(key)}", with: value)
        }

        guard var components = URLComponents(string: baseURL) else {
            throw URLError(.badURL)
        }
        components.scheme = "https"
        components.path += path
        if !request.queryParameters.isEmpty {
            components.queryItems = request.queryParameters.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }
        guard let url = components.url else {
            throw URLError(.badURL)
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method

        urlRequest.setValue("*/*", forHTTPHeaderField: "Accept")

        // FIXME:  **VERY IMPORTANT**: send If-None-Match with the latest ETag
//        let etagValue = #"W/"65a-tkdZSPtsMOfZ1aSNE9H97BksrPc""#
//        urlRequest.setValue(etagValue, forHTTPHeaderField: "If-None-Match")

        if let bodyData = request.bodyData {
            urlRequest.httpBody = bodyData
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        return urlRequest
    }

    func buildMultipartRequest(_ request: some MultipartAPIRequest) -> URLRequest {
        let boundary = UUID().uuidString
        var urlRequest = URLRequest(
            url: URL(string: baseURL + request.endpoint)!,
            cachePolicy: .reloadIgnoringLocalCacheData
        )

        urlRequest.httpMethod = request.method
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()

        for (key, value) in request.fields {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }

        for file in request.files {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(file.name)\"; filename=\"\(file.filename)\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: \(file.mimeType)\r\n\r\n".data(using: .utf8)!)
            body.append(file.data)
            body.append("\r\n".data(using: .utf8)!)
        }

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        urlRequest.httpBody = body

        return urlRequest
    }
}


