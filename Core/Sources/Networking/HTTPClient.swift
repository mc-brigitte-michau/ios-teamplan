// API client
// Request building
// Response parsing 


public protocol HTTPClient {}

public struct HTTPClientImpl: HTTPClient {
    public init() {}
}

public struct DummyHTTPClient: HTTPClient {
    public init() {}
}
