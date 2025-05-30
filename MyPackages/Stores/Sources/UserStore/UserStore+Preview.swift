import Services
import Models
import DataStorage

extension UserStore {

    public static var preview: UserStore {
        let service =  MockAuthService(authUserToReturn: .mock)
        let keychainStorage = MockKeychainStorage()
        try? keychainStorage.save(value: service.authUserToReturn, for: .authUser)
        let store = UserStore(service: service, keychainStorage: keychainStorage)
        store.isLoggedIn = true
        return store
    }

    public static var previewNotLoggedIn: UserStore {
        let service = MockAuthService(signInError: .authorizationFailed)
        let keychainStorage = MockKeychainStorage()
        let store = UserStore(service: service, keychainStorage: keychainStorage)
        store.isLoggedIn = false
        store.user = nil
        return store
    }
}
