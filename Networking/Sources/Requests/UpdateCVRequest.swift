import Models

/// Update a CV
public struct UpdateCVRequest: APIRequest {
    public typealias Response = Candidate
    public typealias Body = Resume

    public let endpoint = "/cv/{id}"
    public let method = "PUT"
    public var pathParameters: [String: String] { ["id": id] }
    public let queryParameters: [String: String] = [:]
    public let body: Body?
    public let id: String

    public init(id: String, resume: Resume) {
        self.id = id
        self.body = resume
    }
}
