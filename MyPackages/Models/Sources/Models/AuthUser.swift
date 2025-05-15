public struct AuthUser: Codable, Equatable, Sendable {
    public let email: String
    public let fullName: String

    public init(
        email: String,
        fullName: String
    ) {
        self.email = email
        self.fullName = fullName
    }
}
