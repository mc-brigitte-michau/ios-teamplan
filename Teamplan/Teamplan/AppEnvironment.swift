import Theme
import Foundation
import CVStore
import Utilities
import Client
import Services

final class AppEnvironment {
    let themeManager: ThemeManager
    let httpClient: HTTPClient
    let cvService: CVService

    init() {
        self.themeManager = ThemeManager()
        httpClient = HTTPClientImpl(baseURL: Bundle.main.apiRoot)
        cvService = CVServiceImpl(httpClient: httpClient)
    }
}
