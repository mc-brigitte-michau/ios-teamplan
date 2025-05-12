import Models

/// Delete a CV
public struct DeleteCVRequest: APIRequest {

    public typealias Response = Empty
    public typealias Body = Empty

    public let endpoint = "/cv/{id}"
    public let method = "DELETE"
    public var pathParameters: [String: String] { ["id": id] }
    public let queryParameters: [String: String] = [:]
    public let body: Body? = nil
    public let id: String

    public init(id: String) {
        self.id = id
    }
}
