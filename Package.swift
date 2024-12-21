// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let GUILinkerSettings: [LinkerSetting] = [
    .unsafeFlags(["-Xlinker", "/SUBSYSTEM:WINDOWS"], .when(configuration: .release)),
    // Update the entry point to point to the generated swift function, this lets us keep the same main method
    // for debug/release
    .unsafeFlags(["-Xlinker", "/ENTRY:mainCRTStartup"], .when(configuration: .release)),
]

let package = Package(
    name: "hellowindows",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .executable(
            name: "hellowindows",
            targets: ["hellowindows"]),
    ],
    dependencies: [
        .package(path: "../UWP"),
        .package(path: "../WinAppSDK"),
        .package(path: "../WindowsFoundation"),
        .package(path: "../WinUI")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "hellowindows",
            dependencies: [
                .product(name: "UWP", package: "UWP"),
                .product(name: "WinAppSDK", package: "WinAppSDK"),
                .product(name: "WindowsFoundation", package: "WindowsFoundation"),
                .product(name: "WinUI", package: "WinUI")
            ],
            linkerSettings: GUILinkerSettings),
        .testTarget(
            name: "hellowindowsTests",
            dependencies: ["hellowindows"]
        ),
    ]
)
