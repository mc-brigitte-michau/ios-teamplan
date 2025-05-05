// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CandidatesFeature",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "CandidatesFeature",
            targets: [
                "Candidates"
            ]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Candidates",
            dependencies: [],
            resources: [.process("Localizable.xcstrings")]
        ),
        .testTarget(
            name: "CandidatesTests",
            dependencies: ["Candidates"]
        )
    ]
)
