import Foundation
import Models
import Requests
import Logging

public actor HTTPClientImpl: HTTPClient, @unchecked Sendable {
    private let session: URLSession
    let baseURL: String

    public init(baseURL: String) {
        self.baseURL = baseURL
        let config = URLSessionConfiguration.default
        config.httpCookieAcceptPolicy = .always
        config.httpShouldSetCookies = true
        session = URLSession(configuration: config)
    }

    public func send<T: APIRequest>(request: T) async throws -> T.Response where T.Response: Sendable  {
        AppLogger.network.debug("Request started: \(request.method) \(request.endpoint)")

        let urlRequest = try buildRequest(request)
        let (data, response) = try await fetchData(with: urlRequest)

        AppLogger.network.debug("Received response: \(request.method) \(request.endpoint)")

        if data.isEmpty, T.Response.self == Empty.self {
            return Empty() as! T.Response
        }

        try validateResponse(data, response: response)

        handleCookies(response: response)

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

    private func fetchData(with request: URLRequest) async throws -> (Data, URLResponse) {
        try await withTimeout(seconds: 20) { [weak self] in
            guard let self else {
                throw HTTPClientError.generalError
            }
            return try await self.session.data(for: request)
        }
    }

    public func send<T: MultipartAPIRequest>(multipartRequest: T) async throws -> T.Response where T.Response: Sendable {
        let urlRequest = buildMultipartRequest(multipartRequest)
        let (data, response) = try await session.data(for: urlRequest)
        try validateResponse(data, response: response)
#if DEBUG
        let log = logNetwork(multipartRequest.method, endpoint: multipartRequest.endpoint, data: data)
        AppLogger.network.debug("\(log)")
#endif
        guard let decoded = JSONDecoder().decodeDebug(T.Response.self, from: data) else {
            throw HTTPClientError.decodingError
        }
        return decoded
    }

    func withTimeout<T: Sendable>(
        seconds timeout: TimeInterval,
        operation: @escaping @Sendable () async throws -> T
    ) async throws -> T {
        try await withThrowingTaskGroup(of: T.self) { group in
            group.addTask {
                try await operation()
            }
            group.addTask {
                try await Task.sleep(nanoseconds: UInt64(timeout * 1_000_000_000))
                throw HTTPClientError.timedOut
            }
            let result = try await group.next()!
            group.cancelAll()
            return result
        }
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

    private func handleCookies(response: URLResponse) {
        if let httpResponse = response as? HTTPURLResponse,
           let url = httpResponse.url {
            let headers = httpResponse.allHeaderFields as? [String: String]
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: headers ?? [:], for: url)
            for cookie in cookies {
                HTTPCookieStorage.shared.setCookie(cookie)
                AppLogger.network.debug("Captured cookie: \(cookie.name)=\(cookie.value)")
            }
        }
    }
}
