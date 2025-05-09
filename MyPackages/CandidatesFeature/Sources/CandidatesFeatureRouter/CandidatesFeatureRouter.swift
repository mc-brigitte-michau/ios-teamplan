import SwiftUI
import CVStore
import Theme
import Candidates

public struct CandidatesFeatureRouter: View {

    @ObservedObject var cvStore: CVStore
    @ObservedObject var themeManager: ThemeManager

    public var body: some View {
        CandidatesScreen()
            .environmentObject(cvStore)
            .environmentObject(themeManager)
    }

    public init(
        cvStore: CVStore,
        themeManager: ThemeManager
    ) {
        self.cvStore = cvStore
        self.themeManager = themeManager
    }
}
