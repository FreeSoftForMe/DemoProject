import ProjectDescription
import ProjectDescriptionHelpers


let dependency: [TargetDependency] = modules + thirdParty

let infoPlist: [String: Plist.Value] = [
    "UILaunchStoryboardName": "LaunchScreen.storyboard",
    "UIApplicationSceneManifest": [
        "UIApplicationSupportsMultipleScenes": false,
        "UISceneConfigurations": [
            "UIWindowSceneSessionRoleApplication": [
                [
                    "UISceneConfigurationName": "Default Configuration",
                    "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                ]
            ]
        ]
    ]
]



let app = Target(name: "DemoProject",
                 destinations: .iOS,
                 product: .app,
                 productName: "DemoProject",
                 bundleId: "myrku.dev.com",
                 infoPlist: .extendingDefault(with: infoPlist),
                 sources: .paths([
                     "Targets/DemoProject/Sources/**",
                 ]),
                 resources: [
                    "Targets/DemoProject/Resources/**",
                 ],
                 dependencies: dependency)

let project = Project(name: "Application",
                      targets: [app])
