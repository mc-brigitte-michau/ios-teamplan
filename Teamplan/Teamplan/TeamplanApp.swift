import SwiftUI
import Services
import Theme
import CVStore
import UserStore

@main
struct TeamplanApp: App {

    @StateObject var cvStore: CVStore
    @StateObject var userStore: UserStore
    let theme: Theme

    init() {
        let env = AppEnvironment()
        let cvStore = CVStore(service: env.cvService)
        _cvStore = StateObject(wrappedValue: cvStore)
        let userStore = UserStore(
            service: env.authService,
            keychainStorage: env.keychainStorage
        )
        _userStore = StateObject(wrappedValue: userStore)
        theme = env.theme
    }

    var body: some Scene {
        WindowGroup {
            RootView(
                cvStore: cvStore,
                userStore: userStore,
                theme: theme
            ).task {
                await userStore.restoreSession()
            }
        }
    }
}
