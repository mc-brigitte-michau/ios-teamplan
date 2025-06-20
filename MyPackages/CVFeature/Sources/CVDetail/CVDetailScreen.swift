import CVStore
import SwiftUI
import ViewState

public struct CVDetailScreen: View {
    @EnvironmentObject private var cvStore: CVStore

    public var body: some View {
        Text(String(localized: "title", bundle: .module))
        Text(cvStore.currentResume?.resumeName ?? "something is wrong")
    }

    public init() {}
}

#Preview {
    CVDetailScreen()
        .environmentObject(CVStore.previewSelected)
}
