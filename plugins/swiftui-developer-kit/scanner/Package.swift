// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "SwiftUIStructuredScanner",
    platforms: [.macOS(.v13)],
    products: [
        .library(name: "SwiftUIScannerCore", targets: ["SwiftUIScannerCore"]),
        .executable(name: "swiftui-scanner", targets: ["SwiftUIScannerCLI"])
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-syntax.git", .upToNextMinor(from: "603.0.0"))
    ],
    targets: [
        .target(
            name: "SwiftUIScannerCore",
            dependencies: [
                .product(name: "SwiftParser", package: "swift-syntax"),
                .product(name: "SwiftSyntax", package: "swift-syntax")
            ]
        ),
        .executableTarget(
            name: "SwiftUIScannerCLI",
            dependencies: ["SwiftUIScannerCore"]
        ),
        .testTarget(
            name: "SwiftUIScannerCoreTests",
            dependencies: ["SwiftUIScannerCore"]
        )
    ]
)
