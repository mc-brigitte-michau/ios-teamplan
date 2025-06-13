public enum LoadState: Equatable {
    case empty
    case failed(String)
    case idle
    case loaded
    case loading
}
