import Theme
import SwiftUICore
import Foundation
import CVStore
import Utilities
import Client
import Services

final class AppEnvironment {
    let theme: Theme
    let httpClient: HTTPClient
    let cvService: CVService
    let authService: AuthService

    init() {
        theme = DefaultTheme()
        httpClient = HTTPClientImpl(baseURL: Bundle.main.apiRoot)
        cvService = CVServiceImpl(httpClient: httpClient)
        authService = AuthServiceImpl(
            httpClient: httpClient,
            domain: Bundle.main.authDomain,
            clientId: Bundle.main.authClientId,
            redirectUri: Bundle.main.authRedirect
        )    }
}
