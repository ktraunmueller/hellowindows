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
        .executable(
            name: "DemoApp",
            targets: ["DemoApp"]),
    ],
    dependencies: [
        .package(path: "../WinAppSDK"),
        .package(path: "../WindowsFoundation"),
        .package(path: "../WinUI")
    ],
    targets: [
        .executableTarget(
            name: "DemoApp",
            dependencies: [
                .product(name: "WinAppSDK", package: "WinAppSDK"),
                .product(name: "WindowsFoundation", package: "WindowsFoundation"),
                .product(name: "WinUI", package: "WinUI")
            ],
            linkerSettings: GUILinkerSettings)
    ],
    swiftLanguageModes: [.v5]
)
