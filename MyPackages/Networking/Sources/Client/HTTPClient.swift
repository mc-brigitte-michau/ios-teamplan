import Foundation
import Models
import Requests
import Logging

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
        AppLogger.network.debug("Request started: \(request.method) \(request.endpoint)")

        let urlRequest = try buildRequest(request)
        let (data, response) = try await session.data(for: urlRequest)
        AppLogger.network.debug("Received response: \(request.method) \(request.endpoint)")

        try validateResponse(data, response: response)
#if DEBUG
        let log = logNetwork(request.method, endpoint: request.endpoint, data: data)
        AppLogger.network.debug("\(log)")
#endif
        guard let decoded = JSONDecoder().decodeDebug(T.Response.self, from: data) else {
            AppLogger.network.error("Decoding Failed")
            throw HTTPClientError.decodingError
        }
        return decoded
    }

    public func send<T: MultipartAPIRequest>(_ request: T) async throws -> T.Response where T.Response: Sendable {
        let urlRequest = buildMultipartRequest(request)
        let (data, response) = try await session.data(for: urlRequest)
        try validateResponse(data, response: response)
#if DEBUG
        let log = logNetwork(request.method, endpoint: request.endpoint, data: data)
        AppLogger.network.debug("\(log)")
#endif
        guard let decoded = JSONDecoder().decodeDebug(T.Response.self, from: data) else {
            throw HTTPClientError.decodingError
        }
        return decoded
    }

    func validateResponse(_ data: Data?, response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            AppLogger.network.error("Invalid HTTP Response")
            throw HTTPClientError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            AppLogger.network.error("Status Code: \(httpResponse.statusCode)")
            let responseText = data.flatMap { String(data: $0, encoding: .utf8) } ?? "No response body"
            throw HTTPClientError.serverError(statusCode: httpResponse.statusCode, body: responseText)
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

extension HTTPClientImpl {
    func logNetwork(_ method: String, endpoint: String, data: Data?) -> String {
    return ("""
    🕒 \(Date())
    🔁 \(method) \(endpoint)
    📦 JSON:
    \(prettyPrintedJSON(from: data) ?? "⚠️ Invalid or empty data")

    """)
    }

    private func prettyPrintedJSON(from data: Data?) -> String? {
        guard let data else { return nil }
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
            return String(data: prettyData, encoding: .utf8)
        } catch {
            AppLogger.network.debug("❌ Failed to pretty-print JSON:, \(error)")
            return nil
        }
    }
}
