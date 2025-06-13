public extension Education {
    static let mock = Education(
        show: true,
        data: [.mock],
        heading: "Education"
    )
}

public extension EducationData {
    static let mock = EducationData(
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
