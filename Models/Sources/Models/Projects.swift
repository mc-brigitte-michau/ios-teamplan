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


extension Projects {
    public static let mock = Projects(
        show: true,
        data: [.mock],
        heading: "Key Projects"
    )
}

extension Project {
    public static let mock = Project(
        id: "project-001",
        technologies: [.mock],
        role: "Lead iOS Developer",
        endDate: "2024-12",
        show: true,
        client: "Mooncascade",
        projectName: "NextGen App",
        roleDescription: "Led a team to develop a cutting-edge mobile app.",
        startDate: "2023-01"
    )
}

extension Technology {
    public static let mock = Technology(
        id: "tech-001",
        show: true,
        label: "SwiftUI"
    )
}
