// API client
// Request building
// Response parsing 

import Foundation
import Models

public protocol HTTPClient {
    func send<T: APIRequest>(_ request: T) async throws -> T.Response
    func send<T: MultipartAPIRequest>(_ request: T) async throws -> T.Response
}

public enum HTTPClientError: Error {
    case invalidResponse
    case httpError(statusCode: Int, body: String)
}

public struct HTTPClientImpl: HTTPClient {
    private let baseURL = "https://yourapi.com"  // change this to your actual API base

    public init() {}

    public func send<T: APIRequest>(_ request: T) async throws -> T.Response {
        let urlRequest = try buildRequest(request)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        try validateResponse(data, response: response)
        return try JSONDecoder().decode(T.Response.self, from: data)
    }

    public func send<T: MultipartAPIRequest>(_ request: T) async throws -> T.Response {
        let urlRequest = buildMultipartRequest(request)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
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

    func buildRequest(_ request: some APIRequest) throws -> URLRequest {
        var path = request.endpoint
        for (key, value) in request.pathParameters {
            path = path.replacingOccurrences(of: "{\(key)}", with: value)
        }

        // Build the full URL with query parameters
        var urlString = baseURL + path
        if !request.queryParameters.isEmpty {
            let query = request.queryParameters
                .map { "\($0.key)=\($0.value)" }
                .joined(separator: "&")
            urlString += "?\(query)"
        }

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        // Build the URLRequest
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method

        // Add body if present
        if let bodyData = request.bodyData {
            urlRequest.httpBody = bodyData
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        return urlRequest
    }
}

public struct DummyHTTPClient: HTTPClient {
    public func send<T: APIRequest>(_ request: T) async throws -> T.Response {
           if let response = DummyData.response(for: T.self) {
               return response
           }
           fatalError("No dummy response defined for APIRequest of type \(T.self)")
       }

       public func send<T: MultipartAPIRequest>(_ request: T) async throws -> T.Response {
           if let response = DummyData.response(for: T.self) {
               return response
           }
           fatalError("No dummy response defined for MultipartAPIRequest of type \(T.self)")
       }

    public init() {}
}

enum DummyData {
    static func response<T>(for requestType: T.Type) -> T.Response? where T: APIRequest {
        switch requestType {
        case is ListCVsRequest.Type:
            return Candidate.mock as? T.Response
        case is GetCVImageRequest.Type:
            return UploadResponse(aws_url: "https://cv-tool-dev.s3.eu-north-1.amazonaws.com/profile-pictures/3fa85f64-5717-4562-b3fc-2c963f66afa6.JPG?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=ASIAZDZTBSZPBJEE5AIL%2F20241204%2Feu-north-1%2Fs3%2Faws4_request&X-Amz-Date=20241204T105502Z&X-Amz-Expires=3600&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEEIaCmV1LW5vcnRoLTEiRzBFAiEAs2dAScMjZW5sy4jZvzDLbI7D%2B1fpb1LEZoJ9mcJSCuMCIDphD31gP30N5Sc9iw9fkTdKH2Ak3pnMiE9BOor9BbB9KocECOz%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEQABoMNjI2NjM1NDEzMDg2Igx0V%2F%2BvSWBNxY5w%2F1Yq2wPVY7btXr5QqNmHpc%2BYGlvWnNY9jViG9kzprF8bQLFv9eot2KLPL8VAd3e0qTv5NWzfNG2U3nGlBQCbQC%2FLZ%2FWQhX3w6jqjYp3t1GRVwi2ECOGrI%2BxizpNDWRiY%2BbctmZDYK%2FFlCfHxCeTCJ%2FadWQR63MS%2F8mLEDXEzlV7%2BLZADQwofE58gZYTB6CtsDI0hgzv4GXu0C%2B1s8xk3I8xBcBJOhJ9prLihpHRURJJEkBdErvGRlc7Std8qdG0WsQNFvcaqECzMRhd6AoD8IN4JMcehckloDED%2Bbyws6%2F758apQFivh%2B6yBWwl3U4pVz1xJ2jyvRjK8fpuP1svRuitNFlWBAX2JxUdBeq10LoZDCddVEamsUcPWyNgv%2FwL4tTbVnhdpja3rbFgVujGmprV2egrMfXJq81C78IrWJOmlVw9qf3aNDMrOe%2BrDwGysVgKbGENCXh51Tpb7Sf40boh1Upfbror0DWKownh0Ngi0qqaCttvubZN4JRVp5mgUk%2BPIDOlDXfXt5B5S7hGQnhsFc%2FRorOSopu6pRwSfOXXu4mXFI6A%2FZnC66pbq8qmrqy%2Bk4NNDbJGzfTXbK%2FOU7IxFd2jN9JGQIfMUQLF%2BI59Mr4GUjzatEkV8N3eGNn1KMPbgwLoGOqUBoNLZAQpCBiaZmKqAKIHsSQmnsdDqyrL5L163nRRdtnyFFvt3VvobHHt5V9zLXKYmNu8SYTu3Zm7wgBnOmUsyKpMyQZ%2BOTrPVGSGALEr6tHAK2n9DpLJloJhn2pcRYtz5bU9ZqzYPLYJeWMB6qzSgNYsXjxuhxv1vNa9Frqgn%2BDONP%2Fv8wqmblloXUIhmEMZjIhfMZ9tdQmFio%2F1Z%2BoJASjuCt1%2Fg&X-Amz-Signature=44f12ed067f5a0c95ab3b79023e8c3737b5069271529f5320147024db50a8a45&X-Amz-SignedHeaders=host&x-id=GetObject") as? T.Response

        default:
            return nil
        }
    }

    static func response<T>(for requestType: T.Type) -> T.Response? where T: MultipartAPIRequest {
        switch requestType {
        case is UploadCVImageRequest.Type:
            fatalError("notimplemented")
            // return UploadResponse(aws_url: "") as? T.Response
        default:
            return nil
        }
    }
}



