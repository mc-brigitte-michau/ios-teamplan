import Foundation

public final class MockKeychainStorage: KeychainStorage {
    public var cookieStorage: [String: HTTPCookie] = [:]
    public var genericStorage: [String: Data] = [:]

    public init() {}

    public func storeCookieToKeychain(_ cookie: HTTPCookie) {
        cookieStorage[cookie.name] = cookie
    }

    public func retrieveCookieFromKeychain(named name: String) -> HTTPCookie? {
        return cookieStorage[name]
    }

    public func save<T: Encodable>(value: T, for key: KeychainKey) throws {
        let data = try JSONEncoder().encode(value)
        genericStorage[key.rawValue] = data
    }

    public func retrieve<T: Decodable>(type: T.Type, for key: KeychainKey) throws -> T? {
        guard let data = genericStorage[key.rawValue] else {
            return nil
        }
        return try JSONDecoder().decode(T.self, from: data)
    }

    public func clearAll() throws {
        cookieStorage = [:]
        genericStorage = [:]
    }
}
