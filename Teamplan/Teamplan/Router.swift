import SwiftUI
import People
import CVList
import Theme

struct Router: View {
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        TabView {
            PeopleScreen()
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
                .preferredColorScheme(.light)

            Router()
                .environmentObject(ThemeManager())
                .preferredColorScheme(.dark)
        }
    }
}
