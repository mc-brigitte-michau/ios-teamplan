import Testing
import Services
import DataStorage
import Models
@testable import UserStore

@Suite
struct UserStoreTests {

    @Test
    @MainActor
    func signInSuccessSetsUserAndIsLoggedIn() async throws {
        let authService = MockAuthService(authUserToReturn: .mock)
        let keychainStorage = MockKeychainStorage()
        let store = UserStore(service: authService, keychainStorage: keychainStorage)
        try await store.signIn()
        #expect(store.isLoggedIn == true)
        #expect(store.user?.fullName == authService.authUserToReturn?.fullName)
    }

    @Test
    @MainActor
    func signInFailureDoesNotSetUser() async {
        let authService = MockAuthService(signInError: .generalError)
        let keychainStorage = MockKeychainStorage()
        let store = UserStore(service: authService, keychainStorage: keychainStorage)

        do {
            try await store.signIn()
            throw HTTPClientError.generalError
        } catch {
            #expect(store.isLoggedIn == false)
            #expect(store.user == nil)
        }
    }

    @Test
    @MainActor
    func signOutClearsUserAndIsLoggedInState() async throws {
        let authService = MockAuthService(authUserToReturn: .mock)
        let keychainStorage = MockKeychainStorage()
        let store = UserStore(service: authService, keychainStorage: keychainStorage)

        try await store.signIn()
        try await store.signOut()

        #expect(store.isLoggedIn == false)
        #expect(store.user == nil)
        #expect(keychainStorage.cookieStorage.isEmpty)
    }

    @Test
    @MainActor
    func restoreSessionWithSavedUserSetsUser() async throws {
        let authService = MockAuthService(authUserToReturn: .mock)
        let keychainStorage = MockKeychainStorage()
        let savedUser = authService.authUserToReturn
        try keychainStorage.save(value: savedUser, for: .authUser)

        let store = UserStore(service: authService, keychainStorage: keychainStorage)
        await store.restoreSession()

        #expect(store.isLoggedIn == true)
        #expect(store.user?.fullName == savedUser?.fullName)
    }

    @Test
    @MainActor
    func restoreSessionWithNoUserClearsState() async {
        let authService = MockAuthService()
        let keychainStorage = MockKeychainStorage()
        let store = UserStore(service: authService, keychainStorage: keychainStorage)

        await store.restoreSession()

        #expect(store.isLoggedIn == false)
        #expect(store.user == nil)
    }
}
