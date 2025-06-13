import Foundation

public struct EmailValidator: Validator {
    public func validate(_ value: String?) -> ValidationResult {
        guard let value else {
            return .invalid(reason: "Enter an email")
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let valid = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: value)
        return valid ? .valid : .invalid(reason: "Invalid email format")
    }
}
