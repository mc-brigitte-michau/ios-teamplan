import SwiftUI
import Networking
import Theme
import CVStore

@main
struct TeamplanApp: App {

    let httpClient = HTTPClientImpl()

    @StateObject var themeManager = ThemeManager()
    @StateObject var cvStore: CVStore

    init() {
        let cvStore = CVStore(httpClient: httpClient)
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
