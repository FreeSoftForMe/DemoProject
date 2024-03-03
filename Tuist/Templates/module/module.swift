import ProjectDescription
import ProjectDescriptionHelpers
import Foundation

let nameAttribute: Template.Attribute = .required("name")
let authorAttribute: Template.Attribute = .optional("author", default: "Dmitrii")

let projectPath = "."
let sourcePath = "Sources/"
let testPath = "UnitTests/Sources"

var defaultYear: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    return dateFormatter.string(from: Date())
}
var defaultDate: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    return dateFormatter.string(from: Date())
}

let dateAttribute: Template.Attribute = .optional("date", default: defaultDate)

let template = Template(
    description: "Custom template",
    attributes: [
        nameAttribute,
        authorAttribute,
        dateAttribute,
    ],
    items: [
        .file(path: projectPath + "/Project.swift", templatePath: "Project.stencil"),
        .file(path: sourcePath + "/ModuleSources.swift", templatePath: "ModuleSources.stencil"),
        .file(path: testPath + "/ModuleUnitTests.swift", templatePath: "ModuleUnitTests.stencil"),
        .file(path: projectPath + "gitignore", templatePath: "gitignore"),
        .file(path: "\(nameAttribute).plist", templatePath: "Module.plist"),
    ]
)
