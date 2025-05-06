import Foundation

public final class ThemeManager: ObservableObject {
    @Published public var currentTheme: Theme = DefaultTheme()

    public init() {}
}
