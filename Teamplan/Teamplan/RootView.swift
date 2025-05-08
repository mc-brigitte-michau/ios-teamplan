import SwiftUI
import Theme
import CVStore

struct RootView: View {

    @ObservedObject var cvStore: CVStore
    @ObservedObject var themeManager: ThemeManager

    var body: some View {
        AppRouter(
            cvStore: cvStore,
            themeManager: themeManager
        )
    }
}
