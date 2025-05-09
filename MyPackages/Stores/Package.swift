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
        )
    ],
    dependencies: [
        .package(path: "../Models"),
        .package(path: "../Networking")
    ],
    targets: [
        .target(
            name: "CVStore",
            dependencies: [
                .product(name: "Networking", package: "Networking"),
                .product(name: "Models", package: "Models")
            ]
        ),
        .target(
            name: "UserStore",
            dependencies: [
                .product(name: "Networking", package: "Networking"),
                .product(name: "Models", package: "Models")
            ]
        ),
        .testTarget(
            name: "CVStoreTests",
            dependencies: ["CVStore"]
        )
    ]
)
