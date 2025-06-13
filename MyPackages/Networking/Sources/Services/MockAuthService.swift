import Foundation
import Models

public struct MockAuthService: AuthService {
    public var authUserToReturn: AuthUser?
    public var signInError: HTTPClientError?

    public init(
        authUserToReturn: AuthUser? = nil,
        signInError: HTTPClientError? = nil
    ) {
        self.authUserToReturn = authUserToReturn
        self.signInError = signInError
    }

    public func signIn() async throws -> AuthUser {
        if let signInError { throw signInError }
        guard let authUserToReturn else {
            throw HTTPClientError.authorizationFailed
        }
        return authUserToReturn
    }

    public func logout() async throws {
#if DEBUG
        print("Mock logout called")
#endif
    }
}
