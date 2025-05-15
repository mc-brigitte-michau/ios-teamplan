import Foundation
import Services
import Models

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

    public func signIn() async throws {
        let result = try await service.signIn()
        self.user = result
        self.isLoggedIn = true
    }

    public func signOut() async throws {
        fatalError()
    }

    public init(service: AuthService) {
        self.service = service
    }

}
