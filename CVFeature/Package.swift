// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CVFeature",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "CVFeature",
            targets: [
                "CVList",
                "CVDetail",
                "AddCV"
            ]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CVList",
            dependencies: [],
            resources: [.process("Localizable.xcstrings")]
        ),
        .target(
            name: "CVDetail",
            dependencies: [],
            resources: [.process("Localizable.xcstrings")]
        ),
        .target(
            name: "AddCV",
            dependencies: [],
            resources: [.process("Localizable.xcstrings")]
        ),
        .testTarget(
            name: "CVListTests",
            dependencies: ["CVList"]
        ),
        .testTarget(
            name: "CVDetailTests",
            dependencies: ["CVDetail"]
        ),
        .testTarget(
            name: "AddCVTests",
            dependencies: ["AddCV"]
        )
    ]
)

