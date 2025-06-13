public struct Header: Codable, Equatable, Sendable {
    private enum CodingKeys: String, CodingKey {
        case summary, mainPhoto, position, certificates
    }

    public let summary: String
    public let mainPhoto: String?
    public let position: String
    public let certificates: [Certificate]

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        summary = try container.decode(String.self, forKey: .summary)
        mainPhoto = try container.decodeIfPresent(String.self, forKey: .mainPhoto)
        position = try container.decode(String.self, forKey: .position)
        certificates = try container.decodeIfPresent([Certificate].self, forKey: .certificates) ?? []
    }

    public init(
        summary: String,
        mainPhoto: String?,
        position: String,
        certificates: [Certificate]
    ) {
        self.summary = summary
        self.mainPhoto = mainPhoto
        self.position = position
        self.certificates = certificates
    }
}

public struct Certificate: Codable, Equatable, Sendable {
    public let id: String
    public let name: String
    public let link: String
    public let show: Bool
}
