import Theme
import SwiftUICore
import Foundation
import CVStore
import Utilities
import Client
import Services
import DataStorage

final class AppEnvironment {
    let theme: Theme
    let httpClient: HTTPClient
    let cvService: CVService
    let authService: AuthService
    let keychainStorage: KeychainStorage

    init() {
        theme = DefaultTheme()
        keychainStorage = KeychainStorageImpl()
        httpClient = HTTPClientImpl(
            baseURL: Bundle.main.apiRoot,
            keychainStorage: KeychainStorageBox(keychainStorage)
        )
        cvService = CVServiceImpl(httpClient: httpClient)
        authService = AuthServiceImpl(
            httpClient: httpClient,
            domain: Bundle.main.authDomain,
            clientId: Bundle.main.authClientId,
            redirectUri: Bundle.main.authRedirect
        )
    }
}
