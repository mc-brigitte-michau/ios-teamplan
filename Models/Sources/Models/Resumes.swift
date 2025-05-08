
public struct Resumes: Codable, Identifiable, Equatable, Sendable {
    public let id: String
    public let resumes: [Resume]
    public let fullName: String
    public let email: String
    public let idCode: String
}

extension Resumes {
    public static let mock = Resumes(
        id: "user-001",
        resumes: [.mock],
        fullName: "Anneli Mutso",
        email: "anneli.mutso@mooncascade.com",
        idCode: "49001010000"
    )
}
