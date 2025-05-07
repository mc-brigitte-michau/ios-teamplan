import SwiftUI
import Networking
import Theme
import CandidateStore
import CVStore

@main
struct TeamplanApp: App {

    let httpClient = HTTPClientImpl()

    @StateObject var themeManager = ThemeManager()
    @StateObject var candidateStore: CandidateStore
    @StateObject var cvStore: CVStore

    init() {
        let candidateStore = CandidateStore(httpClient: httpClient)
        _candidateStore = StateObject(wrappedValue: candidateStore)
        let cvStore = CVStore(httpClient: httpClient)
        _cvStore = StateObject(wrappedValue: cvStore)
    }

    var body: some Scene {
        WindowGroup {
            RootView(
                candidateStore: candidateStore,
                cvStore: cvStore,
                themeManager: themeManager
            )
        }
    }
}
