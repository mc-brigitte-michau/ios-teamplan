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
