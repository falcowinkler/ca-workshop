// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let composableArchitecture: Target.Dependency = .product(
    name: "ComposableArchitecture",
    package: "swift-composable-architecture"
)

let package = Package(
    name: "todos",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Analytics",
            targets: ["Analytics"]),
        .library(
            name: "TaskEditViewFeature",
            targets: ["TaskEditViewFeature"]),
        .library(
            name: "TaskListViewFeature",
            targets: ["TaskListViewFeature"]),
    ],
    dependencies: [
        .package(
            name: "swift-composable-architecture",
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            from: "0.29.0"
        ),
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Analytics",
            dependencies: []),
        .target(
            name: "TaskEditViewFeature",
            dependencies: [
                composableArchitecture
            ]),
        .target(
            name: "TaskListViewFeature",
            dependencies: [
                "TaskEditViewFeature",
                composableArchitecture
            ]),
    ]
)
