import CVStore
import Models

public enum CVRoute {
    case list
    case detail(Resume)
    case add
}

extension CVRoute: Equatable, Identifiable {
    public var id: String {
        switch self {
        case .list:
            return "list"

        case .detail(let cv):
            return "detail_\(cv.id)"

        case .add:
            return "add"
        }
    }
    public static func == (lhs: CVRoute, rhs: CVRoute) -> Bool {
        switch (lhs, rhs) {
        case (.list, .list):
            return true
        case (.add, .add):
            return true
        case let (.detail(lhsCV), .detail(rhsCV)):
            return lhsCV.id == rhsCV.id
        default:
            return false
        }
    }
}
