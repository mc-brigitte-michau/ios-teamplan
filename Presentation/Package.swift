// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Presentation",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Presentation",
            targets: ["Presentation"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Presentation",
            dependencies: [
                "Theme",
                "ViewComponents",
                "ViewState"
            ]
        ),
        .target(
            name: "Theme",
            dependencies: []
        ),
        .target(
            name: "ViewComponents",
            dependencies: []
        ),
        .target(
            name: "ViewState",
            dependencies: []
        ),
        .testTarget(
            name: "ThemeTests",
            dependencies: ["Theme"]
        ),
        .testTarget(
            name: "ViewComponentsTests",
            dependencies: ["ViewComponents"]
        ),
    ]
)
