import Foundation
import Models
import Requests

public protocol HTTPClient {
    func send<T: APIRequest>(request: T) async throws -> T.Response where T.Response: Sendable
    func send<T: MultipartAPIRequest>(multipartRequest: T) async throws -> T.Response where T.Response: Sendable
}
