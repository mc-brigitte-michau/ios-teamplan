public extension Projects {
    static let mock = Projects(
        show: true,
        data: [.mock],
        heading: "Key Projects"
    )
}

public extension Project {
    static let mock = Project(
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

public extension Technology {
    static let mock = Technology(
        id: "tech-001",
        show: true,
        label: "SwiftUI"
    )
}
