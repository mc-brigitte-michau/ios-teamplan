import Foundation
import Models
import Requests
import Logging

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

        if let url = urlRequest.url,
           let cookies = HTTPCookieStorage.shared.cookies(for: url) {
            for cookie in cookies {
                AppLogger.network.debug("Sending cookie:  \(cookie.name)=\(cookie.value)")
            }
        }

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
