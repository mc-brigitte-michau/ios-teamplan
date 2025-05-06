import SwiftUI
import CandidateStore
import Networking
import Theme

@main
struct TeamplanApp: App {

    @StateObject var themeManager = ThemeManager()
    @StateObject var candidateStore = CandidateStore(httpClient: HTTPClientImpl())

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(candidateStore)
                .environmentObject(themeManager)
        }
    }
}
