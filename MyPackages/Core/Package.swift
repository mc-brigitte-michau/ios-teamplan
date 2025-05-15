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
                "DataStorage",
                "Utilities",
                "Logging",
                "Validation"
            ]
        )
    ],
    dependencies: [],
    targets: [
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
        .target(
            name: "Validation",
            dependencies: []
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
