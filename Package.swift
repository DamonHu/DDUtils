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
            targets: ["core", "utils", "ui", "permission"]
        ),
        .library(
            name: "DDUtilsIDFA",
            targets: ["idfa"]
        ),
    ],
    targets: [
        .target(
            name: "core",  // 全小写
            path: "Sources/core"  // 对应全小写目录
        ),
        .target(
            name: "utils",  // 全小写
            dependencies: ["core"],  // 依赖同样小写
            path: "Sources/utils"  // 对应全小写目录
        ),
        .target(
            name: "ui",  // 全小写
            dependencies: ["core"],  // 依赖同样小写
            path: "Sources/ui"  // 对应全小写目录
        ),
        .target(
            name: "permission",  // 全小写
            dependencies: ["core"],  // 依赖同样小写
            path: "Sources/permission"  // 对应全小写目录
        ),
        .target(
            name: "idfa",  // 全小写
            dependencies: ["core", "permission"],  // 依赖同样小写
            path: "Sources/idfa"  // 对应全小写目录
        ),
        .testTarget(
            name: "DDUtilsTests",
            dependencies: ["basic"]
        ),
    ]
)
