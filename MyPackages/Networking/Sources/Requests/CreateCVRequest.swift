import Models

/// Create new CV
public struct CreateCVRequest: APIRequest {
    public typealias Response = Candidate
    public typealias Body = Resume

    public let endpoint = "/cv"
    public let method = "POST"
    public let pathParameters: [String: String] = [:]
    public let queryParameters: [String: String] = [:]
    public let body: Body?

    public init(resume: Resume) {
        self.body = resume
    }
}
