// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Models",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Models",
            targets: [
                "Person",
                "CV"
            ]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Person",
            dependencies: []
        ),
        .target(
            name: "CV",
            dependencies: []
        )
    ]
)
