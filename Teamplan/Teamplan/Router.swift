import SwiftUI
import Candidates
import CVList
import Theme
import CandidateStore
import Networking

struct Router: View {
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        TabView {
            CandidatesScreen()
                .tabItem {
                    Label("All CVs", systemImage: "person.3.fill")
            }
            CVListScreen()
                .tabItem {
                    Label("My CVs", systemImage: "person.fill")
                }
        }
        .background(themeManager.currentTheme.backgroundColor)
    }
}

struct Router_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Router()
                .environmentObject(ThemeManager())
                .environmentObject(CandidateStore.preview)
                .preferredColorScheme(.light)

            Router()
                .environmentObject(ThemeManager())
                .environmentObject(CandidateStore.preview)
                .preferredColorScheme(.dark)
        }
    }
}


