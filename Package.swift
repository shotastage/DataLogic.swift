// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataLogic",
    platforms: [
        .macOS(.v13),
        //.custom("DEB_UBUNTU_Linux", versionString: "22_04"),
        //.custom("NT_Kernel", versionString: "11_22H2"),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DataLogic",
            targets: ["DataLogic"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/google/swift-benchmark", from: "0.1.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DataLogic"),
        .testTarget(
            name: "DataLogicTests",
            dependencies: ["DataLogic"]
        ),
        .executableTarget(
            name: "datalogic-benchmark",
            dependencies: [
                "DataLogic",
                .product(name: "Benchmark", package: "swift-benchmark"),
            ]
        ),
    ]
)
