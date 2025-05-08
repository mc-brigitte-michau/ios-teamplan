
public struct Header: Codable, Equatable, Sendable {
    public let summary: String
    public let mainPhoto: String
    public let position: String
    public let certificates: [Certificate]
}

public struct Certificate: Codable, Equatable, Sendable {
    public let id: String
    public let name: String
    public let link: String
    public let show: Bool
}

extension Header {
    public static let mock = Header(
        summary: "Passionate mobile developer with 8+ years of experience.",
        mainPhoto: "profile_photo.png",
        position: "Senior iOS Engineer",
        certificates: [.mock]
    )
}

extension Certificate {
    public static let mock = Certificate(
        id: "cert-001",
        name: "Swift Advanced Certification",
        link: "https://certificates.example.com/swift-advanced",
        show: true
    )
}

