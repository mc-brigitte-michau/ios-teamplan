public struct Languages: Codable, Equatable, Sendable {
    public let show: Bool
    public let data: [Language]
    public let heading: String
}

public struct Language: Codable, Equatable, Sendable {
    public let id: String
    public let show: Bool
    public let understanding: String
    public let language: String
    public let speaking: String
    public let writing: String
}
