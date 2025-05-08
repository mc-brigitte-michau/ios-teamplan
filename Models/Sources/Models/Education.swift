public struct Education: Codable, Equatable, Sendable {
    public let show: Bool
    public let data: [EducationData]
    public let heading: String
}

public struct EducationData: Codable, Equatable, Sendable {
    public let id: String
    public let major: String
    public let endDate: String
    public let degree: String
    public let show: Bool
    public let schoolLocation: String
    public let schoolName: String
    public let startDate: String
}

extension Education {
    public static let mock = Education(
        show: true,
        data: [.mock],
        heading: "Education"
    )
}

extension EducationData {
    public static let mock = EducationData(
        id: "edu-001",
        major: "Computer Science",
        endDate: "2018-06",
        degree: "BSc",
        show: true,
        schoolLocation: "Tallinn",
        schoolName: "Tallinn University of Technology",
        startDate: "2014-09"
    )
}
