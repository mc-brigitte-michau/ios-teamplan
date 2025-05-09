// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Networking",
            targets: [
                "Client",
                "Requests",
                "Services"
            ]
        )
    ],
    dependencies: [
        .package(path: "../Models"),
        .package(path: "../Core")
    ],
    targets: [
        .target(
            name: "Client",
            dependencies: [
                "Requests",
                .product(name: "Models", package: "Models"),
                .product(name: "Core", package: "Core")
            ]
        ),
        .target(
            name: "Requests",
            dependencies: [
                .product(name: "Models", package: "Models"),
                .product(name: "Core", package: "Core")
            ]
        ),
        .target(
            name: "Services",
            dependencies: [
                "Client",
                "Requests",
                .product(name: "Models", package: "Models"),
                .product(name: "Core", package: "Core")
            ]
        )
    ]
)
