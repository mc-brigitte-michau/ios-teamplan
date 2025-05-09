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
                "Utilities",
                "Logging"
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
            name: "Utilities",
            dependencies: []
        ),
        .target(
            name: "Logging",
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
            name: "UtilitiesTests",
            dependencies: ["Utilities"]
        )
    ]
)
