import SwiftUI

public struct PeopleScreen: View {
    public var body: some View {
        Text(String(localized: "title", bundle: .module))
    }

    public init() {}
}

#Preview {
    PeopleScreen()
}
