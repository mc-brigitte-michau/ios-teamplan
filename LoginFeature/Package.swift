// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoginFeature",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "LoginFeature",
            targets: [
                "Login"
            ]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Login",
            dependencies: []
        ),
        .testTarget(
            name: "LoginTests",
            dependencies: ["Login"]
        )
    ]
)
