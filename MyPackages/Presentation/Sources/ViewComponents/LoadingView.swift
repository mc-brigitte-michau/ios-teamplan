import SwiftUI

public struct LoadingView: View {
    let text: String

    public var body: some View {
        ProgressView(text)
    }

    public init(text: String) {
        self.text = text
    }
}

#Preview {
    LoadingView(text: "Loading...")
}
