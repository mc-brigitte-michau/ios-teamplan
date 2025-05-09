public struct Candidate: Codable, Identifiable, Equatable, Sendable {
    public let id: String
    public let resumes: [Resume]?
    public let fullName: String
    public let email: String?
    public let idCode: String

    public var searchIndex: String = ""

    private enum CodingKeys: String, CodingKey {
        case id, resumes, fullName, email, idCode
    }
}
