public struct Interests: Codable, Equatable, Sendable {
    public let show: Bool
    public let data: [Interest]
    public let heading: String
}

public struct Interest: Codable, Equatable, Sendable {
    public let id: String
    public let show: Bool
    public let interest: String
}
