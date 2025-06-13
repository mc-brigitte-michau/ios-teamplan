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
                "CVFeatureRouter",
                "CVList",
                "CVDetail",
                "AddCV"
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
            name: "CVFeatureRouter",
            dependencies: [
                "CVList",
                "CVDetail",
                "AddCV",
                .product(name: "CVStore", package: "Stores"),
                .product(name: "Presentation", package: "Presentation")
            ]
        ),
        .target(
            name: "CVList",
            dependencies: [
                .product(name: "CVStore", package: "Stores"),
                .product(name: "Models", package: "Models"),
                .product(name: "Presentation", package: "Presentation")
            ],
            resources: [.process("Localizable.xcstrings")]
        ),
        .target(
            name: "CVDetail",
            dependencies: [
                .product(name: "CVStore", package: "Stores"),
                .product(name: "Models", package: "Models"),
                .product(name: "Presentation", package: "Presentation")
            ],
            resources: [.process("Localizable.xcstrings")]
        ),
        .target(
            name: "AddCV",
            dependencies: [
                .product(name: "CVStore", package: "Stores"),
                .product(name: "Models", package: "Models"),
                .product(name: "Presentation", package: "Presentation")
            ],
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
