import ProjectDescription
import ProjectDescriptionHelpers


let dependencies = Dependencies(
swiftPackageManager: .init([
        .remote(url: "https://github.com/pointfreeco/swift-composable-architecture",
                requirement: .exact("1.9.0")),
        .remote(url: "https://github.com/pointfreeco/swift-snapshot-testing",
                requirement: .exact("1.15.3")),
        .remote(url: "https://github.com/layoutBox/PinLayout", 
                requirement: .exact("1.10.5")),
        .remote(url: "https://github.com/Swinject/Swinject",
                requirement: .exact("2.8.4")),
        .remote(url: "https://github.com/krzysztofzablocki/Difference",
                requirement: .exact("1.0.2")),
],
productTypes: ["ComposableArchitecture": .framework,
               "PinLayout": .framework]),
platforms: [.iOS])
