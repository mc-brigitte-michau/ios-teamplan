public extension Skills {
    static let mock = Skills(
        show: true,
        data: [.mock],
        heading: "Technical Skills"
    )
}

public extension SkillData {
    static let mock = SkillData(
        id: "skilldata-001",
        show: true,
        details: [.mock],
        title: "Mobile Development"
    )
}

public extension SkillDetail {
    static let mock = SkillDetail(
        id: "skilldetail-001",
        show: true,
        label: "Swift"
    )
}
