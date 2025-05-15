import SwiftUI
import Theme
import CVStore
import UserStore
import LoginFeatureRouter

struct RootView: View {

    @ObservedObject var cvStore: CVStore
    @ObservedObject var userStore: UserStore

    let theme: Theme

    var body: some View {
        if userStore.isLoggedIn {
            AppRouter(
                cvStore: cvStore,
                theme: theme
            )
        } else {
            LoginFeatureRouter(
                userStore: userStore,
                theme: theme
            )
        }
    }
}
