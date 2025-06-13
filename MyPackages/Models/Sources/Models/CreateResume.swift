public struct CreateResume: Codable, Equatable, Sendable {
    private enum CodingKeys: String, CodingKey {
        case resumes, fullName, email, idCode
    }

    public let resumes: [Resume]
    public let fullName: String
    public let email: String?
    public let idCode: String

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.resumes = try container.decodeIfPresent([Resume].self, forKey: .resumes) ?? []
        self.fullName = try container.decode(String.self, forKey: .fullName)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.idCode = try container.decode(String.self, forKey: .idCode)
    }

    public init(
        resumes: [Resume],
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

public extension Candidate {
    init(from createResume: CreateResume) {
        self.init(
            id: createResume.email ?? "",
            resumes: createResume.resumes,
            fullName: createResume.fullName,
            email: createResume.email ?? "",
            idCode: createResume.idCode
        )
    }
}
