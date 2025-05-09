public enum HTTPClientError: Error {
    case invalidResponse
    case httpError(statusCode: Int, body: String)
}
