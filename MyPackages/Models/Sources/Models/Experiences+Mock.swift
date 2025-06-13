public extension Experiences {
    static let mock = Experiences(
        show: true,
        data: [.mock],
        heading: "Professional Experience"
    )
}

public extension Experience {
    static let mock = Experience(
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

public extension Responsibility {
    static let mock = Responsibility(
        id: "resp-001",
        show: true,
        label: "Managed a team of 5 iOS developers and coordinated project delivery."
    )
}
