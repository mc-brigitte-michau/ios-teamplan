import SwiftUI
import Services
import Theme
import CVStore

@main
struct TeamplanApp: App {

    @StateObject var themeManager = ThemeManager()
    @StateObject var cvStore: CVStore

    init() {
        let env = AppEnvironment()
        let cvStore = CVStore(service: env.cvService)
        _cvStore = StateObject(wrappedValue: cvStore)
    }

    var body: some Scene {
        WindowGroup {
            RootView(
                cvStore: cvStore,
                themeManager: themeManager
            )
        }
    }
}
