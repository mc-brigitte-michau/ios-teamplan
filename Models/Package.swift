// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Models",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Models",
            targets: [
                "CVStore",
                "CandidateStore",
                "UserStore"
            ]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CandidateStore",
            dependencies: []
        ),
        .target(
            name: "CVStore",
            dependencies: []
        ),
        .target(
            name: "UserStore",
            dependencies: []
        )
    ]
)
