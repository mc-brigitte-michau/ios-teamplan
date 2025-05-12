public struct CreateResume: Codable, Equatable, Sendable {
    public let resumes: [Resume]?
    public let fullName: String
    public let email: String?
    public let idCode: String

    private enum CodingKeys: String, CodingKey {
        case resumes, fullName, email, idCode
    }

    public init(
        resumes: [Resume]?,
        fullName: String,
        email: String?,
        idCode: String
    ) {
        self.resumes = resumes
        self.fullName = fullName
        self.email = email
        self.idCode = idCode
    }
}

extension Candidate {
    public init(from createResume: CreateResume) {
        self.init(
            id: createResume.email ?? "",
            resumes: createResume.resumes,
            fullName: createResume.fullName,
            email: createResume.email ?? "",
            idCode: createResume.idCode
        )
    }
}
