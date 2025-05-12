public protocol Validator {
    associatedtype Value
    func validate(_ value: Value) -> ValidationResult
}
