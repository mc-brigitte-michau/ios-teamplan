import Models

/// Gets a list of all CVs
public struct ListCVsRequest: APIRequest {
    public typealias Response = [Candidate]
    public typealias Body = Empty

    public let endpoint = "/cv"
    public let method = "GET"
    public let pathParameters: [String: String] = [:]
    public let queryParameters: [String: String] = [:]
    public let body: Body? = nil
    public init() {}
}
