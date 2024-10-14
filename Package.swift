// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "DDUtils",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "DDUtils",
            targets: ["DDUtils"]
        ),
        .library(
            name: "DDUtilsIDFA",
            targets: ["DDUtilsIDFA"]
        ),
    ],
    targets: [
        .target(
            name: "DDUtils",
            path: "Sources/core"
        ),
        .target(
            name: "DDUtilsIDFA",
            dependencies: ["DDUtils"],
            path: "Sources/idfa"
        ),
    ]
)
