public struct Experiences: Codable, Equatable, Sendable {
    public let show: Bool
    public let data: [Experience]
    public let heading: String
}

public struct Experience: Codable, Equatable, Sendable {
    public let id: String
    public let responsibilities: [Responsibility]
    public let jobLocation: String
    public let endDate: String
    public let jobTitle: String
    public let companyName: String
    public let show: Bool
    public let startDate: String
}

public struct Responsibility: Codable, Equatable, Sendable {
    public let id: String
    public let show: Bool
    public let label: String
}
