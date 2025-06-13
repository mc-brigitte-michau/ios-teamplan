import Foundation

public  protocol MultipartAPIRequest: Sendable {
    associatedtype Response: Decodable

    var endpoint: String { get }
    var method: String { get }
    var files: [MultipartFile] { get }
    var fields: [String: String] { get }
}

public struct MultipartFile {
    public let name: String
    public let filename: String
    public let mimeType: String
    public let data: Data
}

/// Upload image for a CV .../api/files
public struct UploadCVImageRequest: MultipartAPIRequest {
    public typealias Response = UploadResponse

    let cvID: String
    let imageData: Data
    let filename: String

    public var endpoint: String { "/api/files" }
    public let method = "POST"

    public var files: [MultipartFile] {
        [MultipartFile(
            name: "file",
            filename: filename,
            mimeType: "image/jpeg",
            data: imageData
        )]
    }

    public var fields: [String: String] {
        ["cv_id": cvID]
    }
}

public struct UploadResponse: Decodable {
    public let awsUrl: String
}

extension UploadResponse {
    private enum CodingKeys: String, CodingKey {
        case awsUrl = "aws_url"
    }
}

/*
 let imageData = try Data(contentsOf: URL(fileURLWithPath: "your/image/path.jpg"))

 let uploadRequest = UploadCVImageRequest(
     cvID: "abc123",
     imageData: imageData,
     filename: "profile.jpg"
 )

 let urlRequest = buildMultipartRequest(uploadRequest, baseURL: "https://baseapi.com")

 */
