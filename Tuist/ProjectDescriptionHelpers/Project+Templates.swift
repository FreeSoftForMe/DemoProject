import ProjectDescription

public func module(name: String) -> TargetDependency {
    .project(target: name, path: .relativeToRoot("Modules/" + name))
}

public func feature(name: String) -> TargetDependency {
    .project(target: name, path: .relativeToRoot("Features/" + name))
}

extension Project {
    public static func featureFramework(name: String,
                                 bundleId: String? = nil,
                                 dependencies: [TargetDependency] = [],
                                 unitTestDependencies: [TargetDependency] = [],
                                 packages: [Package] = [],
                                 sourcesFlags: String = "",
                                 featureOptions: FeatureFrameworkOptions = .empty) -> Project {
        var dependencies = dependencies

        let prefixBundleId = "myrku.dev.com"
        
        let sourceList: SourceFilesList = {
            var globs = [ProjectDescription.SourceFileGlob]()
            let sources = ProjectDescription.SourceFileGlob.glob("Sources/**/*", compilerFlags: sourcesFlags)
            globs.append(sources)
            return SourceFilesList(globs: globs)
        }()

        var targets: [Target] = []
        
        if featureOptions.contains(.featureProject) {
            targets.append(Target(name: name,
                                  destinations: [.iPhone],
                                  product: .staticLibrary,
                                  bundleId: bundleId ?? "\(prefixBundleId)\(name)",
                                  deploymentTargets: .iOS("17.0"),
                                  infoPlist: .default,
                                  sources: sourceList,
                                  resources: featureOptions.contains(.projectResources) ? "Resources/**" : nil,
                                  dependencies: dependencies))
        } else {
            targets.append(Target(name: name,
                                  destinations: [.iPhone],
                                  product: .framework,
                                  bundleId: bundleId ?? "\(prefixBundleId)\(name)",
                                  deploymentTargets: .iOS("17.0"),
                                  infoPlist: .default,
                                  sources: sourceList,
                                  resources: featureOptions.contains(.projectResources) ? "Resources/**" : nil,
                                  dependencies: dependencies))
        }
        
        if featureOptions.contains(.projectUnitTests) {
            var defaultDependencies = [
                module(name: "UnitTestsUtils"),
            ]
            targets.append(Target(name: "\(name)UnitTests",
                                  destinations: [.iPhone],
                                  product: .unitTests,
                                  bundleId: "\(prefixBundleId)\(name)UnitTests",
                                  deploymentTargets: .iOS("17.0"),
                                  infoPlist: InfoPlist(stringLiteral: "\(name).plist"),
                                  sources: ["UnitTests/Sources/**"],
                                  dependencies: defaultDependencies + unitTestDependencies))
        }


        if featureOptions.contains(.projectSnapshotTests) {
            var defaultDependencies: [TargetDependency] = [
                module(name: "SnapshotTestsUtils"),
            ]

            targets.append(Target(name: "\(name)SnapshotTests",
                                  destinations: [.iPhone],
                                  product: .unitTests,
                                  bundleId: "\(prefixBundleId)\(name)SnapshotTests",
                                  deploymentTargets: .iOS("17.0"),
                                  infoPlist: InfoPlist(stringLiteral: "\(name).plist"),
                                  sources: ["SnapshotTests/Sources/**"],
                                  dependencies: defaultDependencies))
        }

        return Project(name: name,
                       options: .options(disableSynthesizedResourceAccessors: true),
                       packages: packages,
                       targets: targets)
    }
}


public struct FeatureFrameworkOptions: OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let empty: Self = .init([])
    public static let projectSnapshotTests: Self = .init(rawValue: 1 << 1)
    public static let projectResources: Self = .init(rawValue: 1 << 2)
    public static let projectUnitTests: Self = .init(rawValue: 1 << 3)
    public static let featureProject: Self = .init(rawValue: 1 << 4)
}
