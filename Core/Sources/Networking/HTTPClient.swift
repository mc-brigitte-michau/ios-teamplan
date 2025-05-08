// API client
// Request building
// Response parsing 

public protocol HTTPClient {}

public struct HTTPClientImpl: HTTPClient {
    public init() {}

    func send<T: APIRequest>(_ request: T) async throws -> T.Response {
        // URLSession setup and response decoding
        fatalError("not implemented")
    }
}

public struct DummyHTTPClient: HTTPClient {
    public init() {}
}




