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



let app = Target(name: "LearnLanguages",
                 destinations: .iOS,
                 product: .app,
                 productName: "LearnLanguages",
                 bundleId: "myrku.dev.com",
                 infoPlist: .extendingDefault(with: infoPlist),
                 sources: .paths([
                     "Targets/LearnLanguage/Sources/**",
                 ]),
                 resources: [
                    "Targets/LearnLanguage/Resources/**",
                 ],
                 dependencies: dependency)

let project = Project(name: "Application",
                      targets: [app])
