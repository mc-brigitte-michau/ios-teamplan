import Foundation

public struct CV: Codable, Identifiable, Hashable {
    public var id: String
    public let name: String

    public init(
        id: String =  UUID().uuidString,
        name: String
    ) {
        self.id = id
        self.name = name
    }
}
