import SwiftUI
import Candidates
import Theme
import Networking
import CandidatesFeatureRouter
import CVStore // @brigitte = combine the whole feature in import
import CVList
import CVFeatureRouter

struct AppRouter: View {
    @ObservedObject var cvStore: CVStore
    @ObservedObject var themeManager: ThemeManager

    var body: some View {
        TabView {
            CVFeatureRouter(
                cvStore: cvStore,
                themeManager: themeManager
            )
            .tabItem {
                Label(String(localized: "My Resume"), systemImage: "person.fill")
            }
            CandidatesFeatureRouter(
                cvStore: cvStore,
                themeManager: themeManager
            )
            .tabItem {
                Label(String(localized: "All Resumes"), systemImage: "person.3.fill")
            }
        }
        .background(themeManager.currentTheme.backgroundColor)
        .environmentObject(themeManager)
    }
}

struct AppRouter_Previews: PreviewProvider {
    static var previews: some View {

        let themeManager = ThemeManager()
        let cvStore = CVStore.preview

        return Group {
            AppRouter(
                cvStore: cvStore,
                themeManager: themeManager
            )
            .preferredColorScheme(.light)

            AppRouter(
                cvStore: cvStore,
                themeManager: themeManager
            )
            .preferredColorScheme(.dark)
        }
    }
}

