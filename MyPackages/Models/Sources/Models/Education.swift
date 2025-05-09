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
