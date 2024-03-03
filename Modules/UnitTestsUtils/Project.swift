import ProjectDescription
import ProjectDescriptionHelpers


let project = Project.featureFramework(name: "UnitTestsUtils",
                                       dependencies: [
                                        .external(name: "Difference"),
                                        .xctest,
                                       ],
                                       featureOptions: [
                                       ])
