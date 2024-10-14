// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "DDUtils",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "DDUtilsL",
            targets: ["DDUtilsT"]
        ),
        .library(
            name: "DDUtilsIDFAL",
            targets: ["DDUtilsIDFAT"]
        ),
    ],
    targets: [
        .target(
            name: "DDUtilsT",
            path: "Sources/core"
        ),
        .target(
            name: "DDUtilsIDFAT",
            dependencies: ["DDUtilsT"],
            path: "Sources/idfa"
        ),
        .testTarget(
            name: "DDUtilsTests",
            dependencies: ["DDUtilsT"]
        ),
    ]
)
