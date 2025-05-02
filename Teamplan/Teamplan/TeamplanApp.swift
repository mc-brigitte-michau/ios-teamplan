import SwiftUI
import Theme

@main
struct TeamplanApp: App {

    @StateObject var themeManager = ThemeManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
        }
    }
}
