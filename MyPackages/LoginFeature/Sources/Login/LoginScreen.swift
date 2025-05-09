// TODO: extend Authentication to handle Cognito OAuth flow with Google

import SwiftUI

struct LoginScreen: View {
    var body: some View {
        Text(String(localized: "title", bundle: .module))
    }
}

#Preview {
    LoginScreen()
}
