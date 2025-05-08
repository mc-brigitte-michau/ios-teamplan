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

extension Interests {
    public static let mock = Interests(
        show: true,
        data: [.mock],
        heading: "Interests"
    )
}

extension Interest {
    public static let mock = Interest(
        id: "interest-001",
        show: true,
        interest: "Open Source Contributions"
    )
}
