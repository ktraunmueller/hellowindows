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
        .package(url: "https://github.com/ktraunmueller/swift-uwp", branch: "main"),
        .package(url: "https://github.com/ktraunmueller/swift-windowsappsdk", branch: "main"),
        .package(url: "https://github.com/ktraunmueller/swift-windowsfoundation", branch: "main"),
        .package(url: "https://github.com/ktraunmueller/swift-winui", branch: "main")
    ],
    targets: [
        .executableTarget(
            name: "DemoApp",
            dependencies: [
                .product(name: "WinAppSDK", package: "swift-windowsappsdk"),
                .product(name: "WindowsFoundation", package: "swift-windowsfoundation"),
                .product(name: "WinUI", package: "swift-winui")
            ],
            linkerSettings: GUILinkerSettings)
    ],
    swiftLanguageModes: [.v5]
)
