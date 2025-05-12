import Models

/// Update a CV
public struct UpdateCVRequest: APIRequest {
    public typealias Response = Candidate
    public typealias Body = Candidate

    public let endpoint = "/cv/{id}"
    public let method = "PUT"
    public var pathParameters: [String: String] { ["id": id] }
    public let queryParameters: [String: String] = [:]
    public let body: Body?
    public let id: String

    public init(resume: Candidate) {
        self.id = resume.id
        self.body = resume
    }
}
