
public struct Candidate: Codable, Identifiable, Equatable, Sendable {
    public let id: String
    public let resumes: [Resume]
    public let fullName: String
    public let email: String
    public let idCode: String

    public var searchIndex: String = ""
}

extension Candidate {
    public static let mock = Candidate(
        id: "user-001",
        resumes: [.mock],
        fullName: "Barabar Cave",
        email: "barabar.cave@mooncascade.com",
        idCode: "49850347250"
    )
}
