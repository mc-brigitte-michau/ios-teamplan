import SwiftUI
import Theme
import CandidateStore
import CVStore

struct RootView: View {

    @ObservedObject var candidateStore: CandidateStore
    @ObservedObject var cvStore: CVStore
    @ObservedObject var themeManager: ThemeManager

    var body: some View {
        AppRouter(
            candidateStore: candidateStore,
            cvStore: cvStore,
            themeManager: themeManager
        )
    }
}
