import SwiftUI
import Candidates
import Theme
import CandidatesFeatureRouter
import CVStore
import CVFeatureRouter
import CVList
import Services

struct AppRouter: View {
    @ObservedObject var cvStore: CVStore

    let theme: Theme

    var body: some View {
        TabView {
            CVFeatureRouter(
                cvStore: cvStore,
                theme: theme
            )
            .tabItem {
                Label(String(localized: "My Resume"), systemImage: "person.fill")
            }
            CandidatesFeatureRouter(
                cvStore: cvStore,
                theme: theme
            )
            .tabItem {
                Label(String(localized: "All Resumes"), systemImage: "person.3.fill")
            }
        }
        .background(theme.backgroundColor)
        .environment(\.theme, theme)
    }
}

struct AppRouter_Previews: PreviewProvider {
    static var previews: some View {
        let theme = DefaultTheme()
        let cvStore = CVStore.preview

        return Group {
            AppRouter(
                cvStore: cvStore,
                theme: theme
            )
            .preferredColorScheme(.light)

            AppRouter(
                cvStore: cvStore,
                theme: theme
            )
            .preferredColorScheme(.dark)
        }
    }
}

