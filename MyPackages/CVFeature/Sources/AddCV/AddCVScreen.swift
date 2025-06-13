import Presentation
import SwiftUI

public struct AddCVScreen: View {
    @Environment(\.theme)
    private var theme

    public var body: some View {
        ZStack {
            theme.backgroundColor
                .ignoresSafeArea()
            VStack {
                Text(String(localized: "title", bundle: .module))
            }
        }
    }

    public init() {}
}

#Preview {
    AddCVScreen()
}
