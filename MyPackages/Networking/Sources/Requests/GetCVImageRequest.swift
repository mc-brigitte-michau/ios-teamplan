import Models

/// Get image for a CV /api/files/{cv_id}
public struct GetCVImageRequest: APIRequest {
    public typealias Response = UploadResponse
    public typealias Body = Empty

    public let method = "GET"
    public let queryParameters: [String: String] = [:]
    public let cvID: String
    public let body: Body? = nil

    public var endpoint: String { "/api/files/{cv_id}" }
    public var pathParameters: [String: String] { ["cv_id": cvID] }

    public init(cvID: String) {
        self.cvID = cvID
    }
}
