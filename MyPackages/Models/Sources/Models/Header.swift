
public struct Header: Codable, Equatable, Sendable {
    public let summary: String
    public let mainPhoto: String?
    public let position: String
    public let certificates: [Certificate]?
}

public struct Certificate: Codable, Equatable, Sendable {
    public let id: String
    public let name: String
    public let link: String
    public let show: Bool
}
