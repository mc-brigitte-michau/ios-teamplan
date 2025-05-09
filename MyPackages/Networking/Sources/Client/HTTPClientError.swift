public enum HTTPClientError: Error {
    case invalidResponse
    case serverError(statusCode: Int, body: String)
    case decodingError
}
