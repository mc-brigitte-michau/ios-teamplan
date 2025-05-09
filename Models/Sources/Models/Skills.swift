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
