public enum HTTPClientError: Error, Equatable {
    case authorizationFailed
    case decodingError
    case generalError
    case invalidResponse
    case serverError(statusCode: Int, body: String)
    case timedOut
}

public extension HTTPClientError {
     var displayMessage: String {
        switch self {
        case .invalidResponse:
            return "Invalid HTTP response"
        case let .serverError(code, body):
            return "Server error (\(code)): \(body)"
        case .decodingError:
            return "Error decoding JSON response"
        case .timedOut:
            return "Request timed out. Try again"
        case .generalError:
            return "Please try again later"
        case .authorizationFailed:
            return "Login failed or cancelled."
        }
    }
}
