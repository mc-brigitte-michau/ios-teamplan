import CVStore
import Models

public enum CVListEvent: Equatable {
    case add
    case select(Resume)
}
