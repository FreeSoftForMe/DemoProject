import ProjectDescription
import ProjectDescriptionHelpers


let project = Project.featureFramework(name: "SnapshotTestsUtils",
                                       dependencies: [
                                        .external(name: "SnapshotTesting"),
                                        .xctest,
                                       ],
                                       featureOptions: [
                                       ])
