extension Header {
    public static let mock = Header(
        summary: "Passionate mobile developer with 8+ years of experience.",
        mainPhoto: "profile_photo.png",
        position: "Senior iOS Engineer",
        certificates: [.mock]
    )
}

extension Certificate {
    public static let mock = Certificate(
        id: "cert-001",
        name: "Swift Advanced Certification",
        link: "https://certificates.example.com/swift-advanced",
        show: true
    )
}
