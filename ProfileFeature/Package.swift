// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProfileFeature",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "ProfileFeature",
            targets: [
                "Profile"
            ]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Profile",
            dependencies: [],
            resources: [.process("Localizable.xcstrings")]
        ),
        .testTarget(
            name: "ProfileTests",
            dependencies: ["Profile"]
        )
    ]
)
