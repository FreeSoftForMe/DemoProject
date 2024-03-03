//
//  SnapshotTestsUtils
//
//  Created by Dmitrii on 02/03/2024.
//

import UIKit

//TODO: add documentation
public struct SnapshotConfiguration {
    let traits: UITraitCollection
    let name: String
    public init(traits: UITraitCollection,
                name: String) {
        self.traits = traits
        self.name = name
    }

    public static let `default` = SnapshotConfiguration(traits: UITraitCollection(), name: "default")

    public static let darkMode = SnapshotConfiguration(traits: UITraitCollection(userInterfaceStyle: .dark), name: "darkMode")
}
