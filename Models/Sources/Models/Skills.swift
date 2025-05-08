public struct Skills: Codable, Equatable, Sendable {
    public let show: Bool
    public let data: [SkillData]
    public let heading: String
}

public struct SkillData: Codable, Equatable, Sendable {
    public let id: String
    public let show: Bool
    public let details: [SkillDetail]
    public let title: String
}

public struct SkillDetail: Codable, Equatable, Sendable {
    public let id: String
    public let show: Bool
    public let label: String
}

extension Skills {
    public static let mock = Skills(
        show: true,
        data: [.mock],
        heading: "Technical Skills"
    )
}

extension SkillData {
    public static let mock = SkillData(
        id: "skilldata-001",
        show: true,
        details: [.mock],
        title: "Mobile Development"
    )
}

extension SkillDetail {
    public static let mock = SkillDetail(
        id: "skilldetail-001",
        show: true,
        label: "Swift"
    )
}
