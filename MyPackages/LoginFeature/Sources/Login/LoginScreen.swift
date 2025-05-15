import SwiftUI
import Services
import UserStore
import Presentation

public struct LoginScreen: View {
    @EnvironmentObject private var store: UserStore
    @Environment(\.theme) private var theme
    @State private var loadState: LoadState

    public  var body: some View {
        NavigationStack {
            ZStack {
                theme.backgroundColor
                    .ignoresSafeArea()
                VStack {
                    contentView
                }
            }
            .navigationTitle(String(localized: "title", bundle: .module))
            .toolbarBackground(theme.backgroundColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }

    public init(loadState: LoadState = .idle) {
        self._loadState = State(initialValue: loadState)
    }

    @ViewBuilder
    private var contentView: some View {
        switch loadState {
        case .idle:
            signInButton

        case .loading:
            LoadingView(text: "Signing in...")

        case .loaded:
            Text("You should not see this view - navigation broken")

        case .empty:
            Text("You should not see this view - navigation broken")

        case .failed(let error):
            Text("Failed to sign in: \(error)")
        }
    }

    private var signInButton: some View {
        Button("Sign in with Google via Cognito") {
            Task {
                await startLogin()
            }
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(8)
    }

    private func startLogin() async {
        loadState = .loading
        do {
            try await store.signIn()
            if store.isLoggedIn { // @brigitte fishy logic here
                loadState = .empty
            } else {
                loadState = .loaded
            }
        } catch {
            loadState = .failed(error.localizedDescription)
        }
    }

}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginScreen(loadState: .failed("Network error"))
                .environmentObject(UserStore.previewNotLoggedIn)
                .previewDisplayName("Failed state")

            LoginScreen(loadState: .loading)
                .environmentObject(UserStore.previewNotLoggedIn)
                .previewDisplayName("Loading state")

            LoginScreen(loadState: .loaded)
                .environmentObject(UserStore.preview)
                .previewDisplayName("Logged In")
        }
    }
}
