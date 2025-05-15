import SwiftUI
import CVStore
import Theme
import Candidates

public struct CandidatesFeatureRouter: View {

    @ObservedObject var cvStore: CVStore
    let theme: Theme

    public var body: some View {
        CandidatesScreen()
            .environmentObject(cvStore)
            .environment(\.theme, theme)
    }

    public init(
        cvStore: CVStore,
        theme: Theme
    ) {
        self.cvStore = cvStore
        self.theme = theme
    }
}
