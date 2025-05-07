import SwiftUI
import CandidateStore
import Theme
import Candidates

public struct CandidatesFeatureRouter: View {

    @ObservedObject var candidateStore: CandidateStore
    @ObservedObject var themeManager: ThemeManager

    public var body: some View {
        CandidatesScreen()
            .environmentObject(candidateStore)
            .environmentObject(themeManager)
    }

    public init(
        candidateStore: CandidateStore,
        themeManager: ThemeManager
    ) {
        self.candidateStore = candidateStore
        self.themeManager = themeManager
    }
}
