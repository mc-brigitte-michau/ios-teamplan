public extension Languages {
    static let mock = Languages(
        show: true,
        data: [.mock],
        heading: "Languages"
    )
}

public extension Language {
    static let mock = Language(
        id: "lang-001",
        show: true,
        understanding: "Fluent",
        language: "English",
        speaking: "Fluent",
        writing: "Fluent"
    )
}
