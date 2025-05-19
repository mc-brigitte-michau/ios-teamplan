import CVStore
import Models

public enum CVListEvent: Equatable {
    case select(Resume)
    case add
}
