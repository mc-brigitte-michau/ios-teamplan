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
