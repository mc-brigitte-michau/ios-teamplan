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
                "Login",
                "LoginFeatureRouter"
            ]
        )
    ],
    dependencies: [
        .package(path: "../Stores"),
        .package(path: "../Models"),
        .package(path: "../Presentation")
    ],
    targets: [
        .target(
            name: "LoginFeatureRouter",
            dependencies: [
                "Login",
                .product(name: "UserStore", package: "Stores"),
                .product(name: "Models", package: "Models"),
                .product(name: "Presentation", package: "Presentation")
            ]
        ),
        .target(
            name: "Login",
            dependencies: [
                .product(name: "UserStore", package: "Stores"),
                .product(name: "Models", package: "Models"),
                .product(name: "Presentation", package: "Presentation")

            ],
            resources: [.process("Localizable.xcstrings")]
        ),

        .testTarget(
            name: "LoginTests",
            dependencies: ["Login"]
        )
    ]
)
