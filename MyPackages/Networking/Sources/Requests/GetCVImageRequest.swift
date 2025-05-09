import Models

/// Get image for a CV /api/files/{cv_id}
public struct GetCVImageRequest: APIRequest {
    public typealias Response = UploadResponse
    public typealias Body = Empty
    public let cvID: String
    public var endpoint: String { "/api/files/{cv_id}" }
    public let method = "GET"
    public var pathParameters: [String: String] { ["cv_id": cvID] }
    public let queryParameters: [String: String] = [:]
    public let body: Body? = nil
    public init(cvID: String) {
        self.cvID = cvID
    }
}
