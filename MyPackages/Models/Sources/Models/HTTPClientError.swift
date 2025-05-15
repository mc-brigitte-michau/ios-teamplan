public enum HTTPClientError: Error, Equatable {
    case invalidResponse
    case serverError(statusCode: Int, body: String)
    case decodingError
    case timedOut
    case generalError
    case authorizationFailed
}

extension HTTPClientError {

    public var displayMessage: String {
        switch self {
        case .invalidResponse:
            return "Invalid HTTP response"
        case .serverError(statusCode: let code, body: let body):
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
