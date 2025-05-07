import SwiftUI

public struct AddCVScreen: View {
    public var body: some View {
        Text(String(localized: "title", bundle: .module))
    }

    public init() {}
}

#Preview {
    AddCVScreen()
}
