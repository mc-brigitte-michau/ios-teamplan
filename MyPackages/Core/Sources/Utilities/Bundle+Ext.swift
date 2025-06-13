import Foundation

public extension Bundle {
    var apiBaseURL: URL {
        guard let url = URL(string: apiRoot) else {
            fatalError("API_ROOT is not a valid URL: \(apiRoot)")
        }
        return url
    }

    var apiRoot: String {
        guard let apiRoot = object(forInfoDictionaryKey: "API_ROOT") as? String else {
            fatalError("API_ROOT not found in Info.plist. Please check your configuration.")
        }
        return apiRoot
    }

    var authClientId: String {
        guard let authClientId = object(forInfoDictionaryKey: "AUTH_CLIENT_ID") as? String else {
            fatalError("AUTH_CLIENT_ID not found in Info.plist. Please check your configuration.")
        }
        return authClientId
    }

    var authDomain: String {
        guard let authDomain = object(forInfoDictionaryKey: "AUTH_DOMAIN") as? String else {
            fatalError("AUTH_DOMAIN not found in Info.plist. Please check your configuration.")
        }
        return authDomain
    }

    var authRedirect: String {
        guard let authRedirect = object(forInfoDictionaryKey: "AUTH_REDIRECT") as? String else {
            fatalError("AUTH_REDIRECT not found in Info.plist. Please check your configuration.")
        }
        return authRedirect
    }
}
