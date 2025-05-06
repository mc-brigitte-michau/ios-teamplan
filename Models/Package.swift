// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Models",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "CandidateStore",
            targets: ["CandidateStore"]
        ),
        .library(
            name: "CVStore",
            targets: ["CVStore"]
        ),
        .library(
            name: "UserStore",
            targets: ["UserStore"]
        ),
        .library(
            name: "Models",
            targets: [
                "CVStore",
                "CandidateStore",
                "UserStore"
            ]
        )
    ],
    dependencies: [
        .package(path: "../Core")
    ],
    targets: [
        .target(
            name: "CandidateStore",
            dependencies: [
                .product(name: "Core", package: "Core")
            ]
        ),
        .target(
            name: "CVStore",
            dependencies: [
                .product(name: "Core", package: "Core")
            ]
        ),
        .target(
            name: "UserStore",
            dependencies: [
                .product(name: "Core", package: "Core")
            ]
        )
    ]
)
