import SwiftUI
import Networking
import Theme
import CVStore
import Utilities

@main
struct TeamplanApp: App {

    @StateObject var themeManager = ThemeManager()
    @StateObject var cvStore: CVStore

    init() {
        let httpClient = HTTPClientImpl(baseURL: Bundle.main.apiRoot)
        let cvService = CVServiceImpl(httpClient: httpClient)
        let cvStore = CVStore(service: cvService)
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
