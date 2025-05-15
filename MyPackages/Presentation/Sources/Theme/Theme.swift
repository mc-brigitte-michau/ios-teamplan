// Theme protocol
// ThemeManager
// Default themes
// White labeling logic

import SwiftUI

public protocol Theme: Sendable {
    var logo: Image { get }
    var backgroundColor: Color { get }
    var headerColor: Color { get }
}

public struct DefaultTheme: Theme, Sendable {
    public var logo: Image { Image("star.fill") }
    public var backgroundColor: Color { Color("primaryBackground") }
    public var headerColor: Color { Color("primaryBackground") }

    public init() {}
}

public struct ThemeKey: EnvironmentKey {
    public static let defaultValue: Theme = DefaultTheme()
}

public extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}
