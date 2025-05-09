import Foundation

public struct Resume: Codable, Identifiable, Equatable, Sendable {
    public let id: String
    public let resumeName: String
    public let skills: Skills
    public let projects: Projects
    public let education: Education
    public let languages: Languages
    public let header: Header?
    public let interests: Interests
    public let experiences: Experiences
}
