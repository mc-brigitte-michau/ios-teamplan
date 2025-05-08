import Foundation

protocol MultipartAPIRequest {
    associatedtype Response: Decodable

    var endpoint: String { get }
    var method: String { get }  // Always "POST" for uploads
    var files: [MultipartFile] { get }
    var fields: [String: String] { get }
}

struct MultipartFile {
    let name: String
    let filename: String
    let mimeType: String
    let data: Data
}

extension MultipartAPIRequest {
    func buildMultipartRequest(_ request: some MultipartAPIRequest, baseURL: String) -> URLRequest {
        let boundary = UUID().uuidString
        var urlRequest = URLRequest(
            url: URL(string: baseURL + request.endpoint)!,
            cachePolicy: .reloadIgnoringLocalCacheData
        )

        urlRequest.httpMethod = request.method
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()

        for (key, value) in request.fields {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }

        for file in request.files {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(file.name)\"; filename=\"\(file.filename)\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: \(file.mimeType)\r\n\r\n".data(using: .utf8)!)
            body.append(file.data)
            body.append("\r\n".data(using: .utf8)!)
        }

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        urlRequest.httpBody = body

        return urlRequest
    }
}

/// Upload image for a CV .../api/files
struct UploadCVImageRequest: MultipartAPIRequest {
    typealias Response = UploadResponse

    let cvID: String
    let imageData: Data
    let filename: String

    var endpoint: String { "/api/files" }
    let method = "POST"

    var files: [MultipartFile] {
        [MultipartFile(
            name: "file",
            filename: filename,
            mimeType: "image/jpeg",
            data: imageData
        )]
    }

    var fields: [String: String] {
        ["cv_id": cvID]
    }
}

struct UploadResponse: Decodable {
    let aws_url: String
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

