public struct AuthCode: Codable, Equatable, Sendable {
    public let authorizationCode: String
    public let redirectUri: String
    
    public init(
        authorizationCode: String,
        redirectUri: String
    ) {
        self.authorizationCode = authorizationCode
        self.redirectUri = redirectUri
    }
}
