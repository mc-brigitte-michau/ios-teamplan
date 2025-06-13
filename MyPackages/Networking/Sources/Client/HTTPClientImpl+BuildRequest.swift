import Foundation
import Logging
import Models
import Requests

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
            components.queryItems = request.queryParameters.map { parameter in
                URLQueryItem(name: parameter.key, value: parameter.value)
            }
        }
        guard let url = components.url else {
            throw URLError(.badURL)
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method

        if let url = urlRequest.url,
           let cookies = HTTPCookieStorage.shared.cookies(for: url) {
            for cookie in cookies {
                AppLogger.network.debug("Sending cookie: \(cookie.name)=\(cookie.value)")
            }
        }

        urlRequest.setValue("*/*", forHTTPHeaderField: "Accept")

        // FIXME: **VERY IMPORTANT**: send If-None-Match with the latest ETag
        // let etagValue = #"W/"65a-tkdZSPtsMOfZ1aSNE9H97BksrPc""#
        // urlRequest.setValue(etagValue, forHTTPHeaderField: "If-None-Match")

        if let bodyData = request.bodyData {
            urlRequest.httpBody = bodyData
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        return urlRequest
    }

    func buildMultipartRequest(_ request: some MultipartAPIRequest) -> URLRequest? {
        let boundary = UUID().uuidString

        guard let url = URL(string: baseURL + request.endpoint) else {
            AppLogger.network.debug("❌ Invalid URL")
            return nil
        }

        var urlRequest = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData
        )

        urlRequest.httpMethod = request.method
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()

        func safeAppend(_ string: String) {
            guard let data = string.data(using: .utf8) else {
                AppLogger.network.debug("❌ Failed to encode string: \(string)")
                return
            }
            body.append(data)
        }

        for (key, value) in request.fields {
            safeAppend("--\(boundary)\r\n")
            safeAppend("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            safeAppend("\(value)\r\n")
        }

        for file in request.files {
            safeAppend("--\(boundary)\r\n")
            safeAppend("Content-Disposition: form-data; name=\"\(file.name)\"; filename=\"\(file.filename)\"\r\n")
            safeAppend("Content-Type: \(file.mimeType)\r\n\r\n")
            body.append(file.data)
            safeAppend("\r\n")
        }

        safeAppend("--\(boundary)--\r\n")

        urlRequest.httpBody = body
        return urlRequest
    }
}
