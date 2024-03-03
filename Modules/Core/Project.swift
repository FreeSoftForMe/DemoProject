import ProjectDescription
import ProjectDescriptionHelpers


let project = Project.featureFramework(name: "Core",
                                       dependencies: [
                                        .external(name: "Swinject"),
                                        module(name: "Common"),
                                        module(name: "Interfaces"),
                                       ],
                                       featureOptions: [
                                        .projectUnitTests
                                       ])
