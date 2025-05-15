import Services
import Models

extension UserStore {

    public static var preview: UserStore {
        let service =  MockAuthService(authUserToReturn: .mock)
        let store = UserStore(service: service)
        store.isLoggedIn = true
        return store
    }

    public static var previewNotLoggedIn: UserStore {
        let service = MockAuthService(signInError: .authorizationFailed)
        let store = UserStore(service: service)
        store.isLoggedIn = false
        store.user = nil
        return store
    }
}
