public struct Candidate: Codable, Identifiable, Equatable, Sendable {
    private enum CodingKeys: String, CodingKey {
        case id, resumes, fullName, email, idCode
    }

    public let id: String
    public let resumes: [Resume]
    public let fullName: String
    public let email: String?
    public let idCode: String

    public var searchIndex: String = ""

    public init(
        id: String,
        resumes: [Resume],
        fullName: String,
        email: String?,
        idCode: String
    ) {
        self.id = id
        self.resumes = resumes
        self.fullName = fullName
        self.email = email
        self.idCode = idCode
    }
}
