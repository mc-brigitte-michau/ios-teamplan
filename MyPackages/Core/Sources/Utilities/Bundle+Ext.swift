import Foundation

extension Bundle {

    public var apiBaseURL: URL {
        guard let url = URL(string: apiRoot) else {
            fatalError("API_ROOT is not a valid URL: \(apiRoot)")
        }
        return url
    }

    public var apiRoot: String {
        guard let apiRoot = object(forInfoDictionaryKey: "API_ROOT") as? String else {
            fatalError("API_ROOT not found in Info.plist. Please check your configuration.")
        }
        return apiRoot
    }
}
