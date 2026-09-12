import Foundation
// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "SwiftEnvKit",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "SwiftEnvKit",
            targets: ["SwiftEnvKit"]
        )
    ],
    targets: [
        .target(
            name: "SwiftEnvKit"
        ),
        .testTarget(
            name: "SwiftEnvKitTests",
            dependencies: ["SwiftEnvKit"]
        )
    ],
    swiftLanguageModes: [.v6]
)
