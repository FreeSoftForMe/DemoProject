import ProjectDescription
import ProjectDescriptionHelpers


let project = Project.featureFramework(name: "MainScreenFeature",
                                       dependencies: [
                                        .external(name: "Swinject"),
                                        .external(name: "ComposableArchitecture"),
                                        module(name: "UIComponents"),
                                        module(name: "Core"),
                                       ],
                                       featureOptions: [
                                        .projectUnitTests,
                                        .featureProject
                                       ])
