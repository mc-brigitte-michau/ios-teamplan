import DataStorage
import Models
import Services

public extension UserStore {
    static var preview: UserStore {
        let service = MockAuthService(authUserToReturn: .mock)
        let keychainStorage = MockKeychainStorage()
        try? keychainStorage.save(value: service.authUserToReturn, for: .authUser)
        let store = UserStore(service: service, keychainStorage: keychainStorage)
        store.isLoggedIn = true
        return store
    }

    static var previewNotLoggedIn: UserStore {
        let service = MockAuthService(signInError: .authorizationFailed)
        let keychainStorage = MockKeychainStorage()
        let store = UserStore(service: service, keychainStorage: keychainStorage)
        store.isLoggedIn = false
        store.user = nil
        return store
    }
}
