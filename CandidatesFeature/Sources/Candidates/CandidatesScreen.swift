import SwiftUI

public struct CandidatesScreen: View {
    public var body: some View {
        Text(String(localized: "title", bundle: .module))
    }

    public init() {}
}

#Preview {
    CandidatesScreen()
}
