import Models

/// Gets one single CV
public struct ListCVRequest: APIRequest {
    public typealias Response = Candidate
    public typealias Body = Empty

    public var endpoint: String { "/cv/{id}" }
    public let method = "GET"
    public var pathParameters: [String: String] { ["id": id] }
    public let queryParameters: [String: String] = [:]
    public let body: Body? = nil
    public let id: String

    public init(id: String) {
        self.id = id
    }
}
