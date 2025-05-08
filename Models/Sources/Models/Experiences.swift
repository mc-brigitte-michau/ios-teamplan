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

extension Experiences {
    public static let mock = Experiences(
        show: true,
        data: [.mock],
        heading: "Professional Experience"
    )
}

extension Experience {
    public static let mock = Experience(
        id: "exp-001",
        responsibilities: [.mock],
        jobLocation: "Tallinn, Estonia",
        endDate: "2024-12",
        jobTitle: "Lead iOS Developer",
        companyName: "Mooncascade",
        show: true,
        startDate: "2020-03"
    )
}

extension Responsibility {
    public static let mock = Responsibility(
        id: "resp-001",
        show: true,
        label: "Managed a team of 5 iOS developers and coordinated project delivery."
    )
}
