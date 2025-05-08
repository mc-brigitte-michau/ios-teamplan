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
                "CandidatesFeatureRouter",
                "Candidates"
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
            name: "CandidatesFeatureRouter",
            dependencies: [
                "Candidates",
                .product(name: "CandidateStore", package: "Stores"),
                .product(name: "Models", package: "Models"),
                .product(name: "Presentation", package: "Presentation")
            ]
        ),
        .target(
            name: "Candidates",
            dependencies: [
                .product(name: "CandidateStore", package: "Stores"),
                .product(name: "Presentation", package: "Presentation")
            ],
            resources: [.process("Localizable.xcstrings")]
        ),
        .testTarget(
            name: "CandidatesTests",
            dependencies: ["Candidates"]
        )
    ]
)
