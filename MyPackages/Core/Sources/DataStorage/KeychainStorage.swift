import Security
import Foundation

public enum KeychainKey: String {
    case authUser = "auth_user"
    case authToken = "cv_tool_access_token"
}

public struct KeychainStorageBox: @unchecked Sendable {
    public let base: KeychainStorage

    public init(_ base: KeychainStorage) {
        self.base = base
    }
}

public protocol KeychainStorage {
    func storeCookieToKeychain(_ cookie: HTTPCookie)
    func retrieveCookieFromKeychain(named name: String) -> HTTPCookie?

    func save<T: Encodable>(value: T, for key: KeychainKey) throws
    func retrieve<T: Decodable>(type: T.Type, for key: KeychainKey) throws -> T?

    func clearAll() throws
}

public struct KeychainStorageImpl: KeychainStorage {

    public init() {}

    public func storeCookieToKeychain(_ cookie: HTTPCookie) {
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: cookie, requiringSecureCoding: false) else { return }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: cookie.name,
            kSecValueData as String: data
        ]

        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }

    public func retrieveCookieFromKeychain(named name: String) -> HTTPCookie? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: name,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var result: AnyObject?
        guard SecItemCopyMatching(query as CFDictionary, &result) == errSecSuccess,
              let data = result as? Data,
              let cookies = try? NSKeyedUnarchiver.unarchivedObject(
                ofClasses: [NSArray.self, HTTPCookie.self],
                from: data
              ) as? [HTTPCookie] else {
            return nil
        }

        return cookies.first
    }

    public func save<T: Encodable>(value: T, for key: KeychainKey) throws {
        let data = try JSONEncoder().encode(value)

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecValueData as String: data
        ]

        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            throw NSError(domain: "KeychainError", code: Int(status), userInfo: [NSLocalizedDescriptionKey: "Failed to save to Keychain"])
        }
    }

    public func retrieve<T: Decodable>(type: T.Type, for key: KeychainKey) throws -> T? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        if status == errSecItemNotFound {
            return nil
        }

        guard status == errSecSuccess,
              let data = result as? Data else {
            throw NSError(domain: "KeychainError", code: Int(status), userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve from Keychain"])
        }

        return try JSONDecoder().decode(T.self, from: data)
    }

    public func clearAll() throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword
        ]

        let status = SecItemDelete(query as CFDictionary)
        if status != errSecSuccess && status != errSecItemNotFound {
            throw NSError(
                domain: "KeychainError",
                code: Int(status),
                userInfo: [NSLocalizedDescriptionKey: "Failed to clear keychain: \(status)"]
            )
        }
    }
}
