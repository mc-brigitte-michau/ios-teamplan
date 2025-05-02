import SwiftUI

public struct CVListView: View {
    public var body: some View {
        Text(String(localized: "title", bundle: .module))
    }

    public init() { 
    }
}

#Preview {
    CVListView()
}
