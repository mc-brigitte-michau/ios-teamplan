public struct Projects: Codable, Equatable, Sendable {
    public let show: Bool
    public let data: [Project]
    public let heading: String
}

public struct Project: Codable, Equatable, Sendable {
    public let id: String
    public let technologies: [Technology]
    public let role: String
    public let endDate: String
    public let show: Bool
    public let client: String
    public let projectName: String
    public let roleDescription: String
    public let startDate: String
}

public struct Technology: Codable, Equatable, Sendable {
    public let id: String
    public let show: Bool
    public let label: String
}
