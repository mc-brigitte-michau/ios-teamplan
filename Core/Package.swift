// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Core",
            targets: [
                "Authentication",
                "DataStorage",
                "Networking",
                "Theme",
                "Utilities"
            ]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Authentication",
            dependencies: []
        ),
        .target(
            name: "DataStorage",
            dependencies: []
        ),
        .target(
            name: "Networking",
            dependencies: []
        ),
        .target(
            name: "Theme",
            dependencies: []
        ),
        .target(
            name: "Utilities",
            dependencies: []
        ),
        .testTarget(
            name: "AuthenticationTests",
            dependencies: ["Authentication"]
        ),
        .testTarget(
            name: "DataStorageTests",
            dependencies: ["DataStorage"]
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]
        ),
        .testTarget(
            name: "ThemeTests",
            dependencies: ["Theme"]
        ),
        .testTarget(
            name: "UtilitiesTests",
            dependencies: ["Utilities"]
        )
    ]
)
