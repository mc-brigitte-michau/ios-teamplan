import Models

/// Authorize user
public struct AuthRequest: APIRequest {
    public typealias Response = AuthUser
    public typealias Body = AuthCode

    public let endpoint = "/authentication/authorize"
    public let method = "POST"
    public let pathParameters: [String: String] = [:]
    public let queryParameters: [String: String] = [:]
    public let body: Body?

    public init(auth: AuthCode) {
        self.body = auth
    }
}
