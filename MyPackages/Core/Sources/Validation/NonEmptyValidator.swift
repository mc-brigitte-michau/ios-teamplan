public struct NonEmptyValidator: Validator {
    public func validate(_ value: String?) -> ValidationResult {
        guard let value = value?.trimmingCharacters(in: .whitespacesAndNewlines),
              !value.isEmpty else {
            return .invalid(reason: "Field must not be empty")
        }
        return .valid
    }
}
