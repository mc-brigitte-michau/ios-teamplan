import os
import Foundation

public enum AppLogger {

    public static let network = Logger(subsystem: subsystem, category: "network")
    public static let auth = Logger(subsystem: subsystem, category: "auth")
    public static let ui = Logger(subsystem: subsystem, category: "ui")

    private static let subsystem: String = {
        Bundle.main.bundleIdentifier ?? "com.mooncascade.com"
    }()

    public static func make(_ category: String) -> Logger {
        Logger(subsystem: subsystem, category: category)
    }
}
