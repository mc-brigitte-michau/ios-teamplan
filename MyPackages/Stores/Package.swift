// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Stores",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "CVStore",
            targets: ["CVStore"]
        ),
        .library(
            name: "UserStore",
            targets: ["UserStore"]
        ),
        .library(
            name: "SharedStore",
            targets: ["SharedStore"]
        )
    ],
    dependencies: [
        .package(path: "../Models"),
        .package(path: "../Networking"),
        .package(path: "../Core")
    ],
    targets: [
        .target(
            name: "CVStore",
            dependencies: [
                "SharedStore",
                .product(name: "Networking", package: "Networking"),
                .product(name: "Models", package: "Models")
            ]
        ),
        .target(
            name: "UserStore",
            dependencies: [
                "SharedStore",
                .product(name: "Networking", package: "Networking"),
                .product(name: "Models", package: "Models"),
                .product(name: "Core", package: "Core")
            ]
        ),
        .target(
            name: "SharedStore",
            dependencies: []
        ),
        .testTarget(
            name: "CVStoreTests",
            dependencies: ["CVStore", "SharedStore"]
        ),
        .testTarget(
            name: "UserStoreTests",
            dependencies: ["UserStore", "SharedStore", "Core"]
        )
    ]
)
