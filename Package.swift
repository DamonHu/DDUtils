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
            name: "DDUtils",  // 全小写
            path: "Sources/core"  // 对应全小写目录
        ),
        .target(
            name: "DDUtilsIDFA",  // 全小写
            dependencies: ["DDUtils"],  // 依赖同样小写
            path: "Sources/idfa"  // 对应全小写目录
        ),
        .testTarget(
            name: "DDUtilsTests",
            dependencies: ["DDUtils"]
        ),
    ]
)
