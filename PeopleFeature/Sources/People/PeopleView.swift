import SwiftUI

public struct PeopleView: View {
    public var body: some View {
        Text(String(localized: "title", bundle: .module))
    }

    public init() {}
}

#Preview {
    PeopleView()
}
