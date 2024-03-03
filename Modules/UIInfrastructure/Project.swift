import ProjectDescription
import ProjectDescriptionHelpers


let project = Project.featureFramework(name: "UIInfrastructure",
                                       dependencies: [
                                        .external(name: "PinLayout"),
                                       ],
                                       featureOptions: [
                                       ])
