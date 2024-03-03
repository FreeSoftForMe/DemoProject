import ProjectDescription
import ProjectDescriptionHelpers


let project = Project.featureFramework(name: "UIComponents",
                                       dependencies: [
                                        module(name: "Common"),
                                        module(name: "UIInfrastructure"),
                                       ],
                                       featureOptions: [
                                        .projectSnapshotTests,
                                       ])
