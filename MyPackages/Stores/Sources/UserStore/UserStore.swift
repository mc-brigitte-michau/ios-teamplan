import Foundation
import Services
import Models
import DataStorage
import Logging

@MainActor
public protocol UserStoreProtocol: AnyObject, ObservableObject {
    var isLoggedIn: Bool { get set }

    func signIn() async throws
    func signOut() async throws
}

public class UserStore: UserStoreProtocol, @unchecked Sendable {

    @Published public var isLoggedIn: Bool = false
    @Published public var user: AuthUser?

    private let service: AuthService
    private let keychainStorage: KeychainStorage

    public func signIn() async throws {
        let result = try await service.signIn()
        self.user = result
        try? keychainStorage.save(value: result, for: .authUser)
        self.isLoggedIn = true
    }

    public func signOut() async throws {
        try keychainStorage.clearAll()
        clearSessionCookies()
        self.user = nil
        isLoggedIn = false
    }

    public init(
        service: AuthService,
        keychainStorage: KeychainStorage
    ) {
        self.service = service
        self.keychainStorage = keychainStorage
    }
}

// MARK: Session

extension UserStore {

    public func restoreSession() async {
        if let savedUser = try? keychainStorage.retrieve(type: AuthUser.self, for: .authUser) {
            self.user = savedUser
            restoreSessionCookies()
            self.isLoggedIn = true
        } else {
            self.user = nil
            self.isLoggedIn = false
        }
    }

    private func restoreSessionCookies() {
        let cookieNames = [KeychainKey.authToken.rawValue]
        for name in cookieNames {
            if let cookie = keychainStorage.retrieveCookieFromKeychain(named: name) {
                HTTPCookieStorage.shared.setCookie(cookie)
                AppLogger.auth.debug("Restored cookie from keychain: \(cookie.name)")
            }
        }
    }

    private  func clearSessionCookies() {
        let cookieNames = [KeychainKey.authToken.rawValue]

        for name in cookieNames {
            if let cookies = HTTPCookieStorage.shared.cookies {
                for cookie in cookies where cookie.name == name {
                    HTTPCookieStorage.shared.deleteCookie(cookie)
                    AppLogger.auth.debug("Deleted cookie from shared storage: \(cookie.name)")
                }
            }
        }
    }
}
