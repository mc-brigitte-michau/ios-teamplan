// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PeopleFeature",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "PeopleFeature",
            targets: [
                "People"
            ]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "People",
            dependencies: [],
            resources: [.process("Localizable.xcstrings")]
        ),
        .testTarget(
            name: "PeopleTests",
            dependencies: ["People"]
        )
    ]
)
