import Foundation
import Models
import AuthenticationServices
import SwiftUI
import Requests
import Client

public protocol AuthService: Sendable {
    func signIn() async throws -> AuthUser
    func logout() async throws
}

public class AuthServiceImpl: NSObject, ObservableObject, ASWebAuthenticationPresentationContextProviding, AuthService {

    private let httpClient: HTTPClient & Sendable

    private var authSession: ASWebAuthenticationSession?
    private let domain: String
    private let clientId: String
    private let redirectUri: String
    private let responseType = "code"

    public init(
        httpClient: HTTPClient & Sendable,
        domain: String,
        clientId: String,
        redirectUri: String
    ) {
        self.httpClient = httpClient
        self.domain = domain
        self.clientId = clientId
        self.redirectUri = redirectUri
    }

    public func signIn() async throws -> AuthUser {
        let awsCode = try await startAWSCognitoLogin()
        return try await authorize(with: awsCode)
    }

    public func logout() async throws {
        fatalError()
    }

    private func authorize(with code: String) async throws -> AuthUser {
        let auth = AuthCode(
            authorizationCode: code,
            redirectUri: redirectUri
        )
        let request = AuthRequest(auth: auth)
        return try await httpClient.send(request: request)
    }

    public func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow } ?? ASPresentationAnchor()
    }
}

// MARK: AWS Cognito
private extension AuthServiceImpl {

    func startAWSCognitoLogin() async throws -> String {

        let authUrlString = """
        https://\(domain)/login?response_type=\(responseType)&client_id=\(clientId)&redirect_uri=\(redirectUri)
        """

        guard let authUrl = URL(string: authUrlString) else {
            throw HTTPClientError.generalError
        }

        return try await withCheckedThrowingContinuation { continuation in

            authSession = ASWebAuthenticationSession(url: authUrl, callbackURLScheme: "teamplan") { callbackURL, error in

                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }

                guard let callbackURL = callbackURL,
                      let code = URLComponents(url: callbackURL, resolvingAgainstBaseURL: false)?
                    .queryItems?.first(where: { $0.name == "code" })?.value else {
                    continuation.resume(throwing: HTTPClientError.authorizationFailed)
                    return

                }
                continuation.resume(returning: code)
            }
            authSession?.presentationContextProvider = self
            authSession?.prefersEphemeralWebBrowserSession = true
            authSession?.start()
        }
    }
}
