extension Languages {
    public static let mock = Languages(
        show: true,
        data: [.mock],
        heading: "Languages"
    )
}

extension Language {
    public static let mock = Language(
        id: "lang-001",
        show: true,
        understanding: "Fluent",
        language: "English",
        speaking: "Fluent",
        writing: "Fluent"
    )
}
