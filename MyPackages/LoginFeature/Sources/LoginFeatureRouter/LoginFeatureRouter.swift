import Theme
import SwiftUICore
import Login
import UserStore

public struct LoginFeatureRouter: View {

    @ObservedObject var userStore: UserStore
    let theme: Theme

    public var body: some View {
        LoginScreen()
            .environmentObject(userStore)
            .environment(\.theme, theme)
    }

    public init(
        userStore: UserStore,
        theme: Theme
    ) {
        self.userStore = userStore
        self.theme = theme
    }
}
