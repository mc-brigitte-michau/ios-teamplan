// Theme protocol
// ThemeManager
// Default themes
// White labeling logic

import SwiftUI

public protocol Theme {
    var logo: Image { get }
    var backgroundColor: Color { get }
    var headerColor: Color { get }
}

public struct DefaultTheme: Theme {
    public var logo: Image = Image(systemName: "star.fill")
    public var backgroundColor: Color = Color(.systemBackground)
    public var headerColor: Color = Color(.label)
}
