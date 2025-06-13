import Foundation
import Models

public protocol APIRequest: Sendable {
    associatedtype Response: Decodable
    associatedtype Body: Encodable

    var endpoint: String { get }
    var method: String { get }
    var pathParameters: [String: String] { get }
    var queryParameters: [String: String] { get }
    var body: Body? { get }
}

public  extension APIRequest {
    var bodyData: Data? {
        guard let body else { return nil }
        return try? JSONEncoder().encode(body)
    }
}
