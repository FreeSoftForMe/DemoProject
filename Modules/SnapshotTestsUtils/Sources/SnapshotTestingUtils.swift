//
//  SnapshotTestingUtils.swift
//  SnapshotTestsUtils
//
//  Created by Dmitrii on 3/2/24.
//

import Foundation
import SnapshotTesting
import UIKit
import XCTest

/// The default `perceptualPrecision` to use if a specific value is not provided.
private let defaultPerceptualPrecision: Float = {
    #if arch(x86_64)
        // When executing on Intel (CI machines) lower the `defaultPerceptualPrecision` to 98% which avoids failing tests
        // due to imperceivable differences in anti-aliasing, shadows, and blurs between Intel and Apple Silicon Macs.
        return 0.98
    #else
        // The snapshots were generated on Apple Silicon Macs, so they match 100%.
        return 1.0
    #endif
}()

//TODO: add documentation
extension Snapshotting where Value == UIView, Format == UIImage {
    static let image = image(perceptualPrecision: defaultPerceptualPrecision)
    
    static func customImage(drawHierarchyInKeyWindow: Bool = false,
                            precision: Float,
                            perceptualPrecision: Float,
                            size: CGSize? = nil,
                            traits: UITraitCollection = .init()) -> Self {
        image(drawHierarchyInKeyWindow: drawHierarchyInKeyWindow,
              precision: precision,
              perceptualPrecision: perceptualPrecision,
              size: size,
              traits: traits)
    }
}

extension Snapshotting where Value == UIViewController, Format == UIImage {
    static let image = image(perceptualPrecision: defaultPerceptualPrecision)
    
    static func customImage(on config: ViewImageConfig,
                            precision: Float,
                            perceptualPrecision: Float,
                            size: CGSize? = nil,
                            traits: UITraitCollection = .init()) -> Self {
        image(on: config,
              precision: precision,
              perceptualPrecision: perceptualPrecision,
              size: size,
              traits: traits)
    }
}

public func assertSnapshots<View: UIView>(configs: [SnapshotConfiguration] = [.default],
                                          matching: @autoclosure () throws -> View,
                                          configure: (View) -> View,
                                          size: () -> CGSize,
                                          precision: Float = 1,
                                          perceptualPrecision: Float? = nil,
                                          record recording: Bool = false,
                                          file: StaticString = #file,
                                          testName: String = #function,
                                          line: UInt = #line) {
    for config in configs {
        try assertSnapshot(of: configure(matching()),
                           as: .customImage(precision: precision,
                                            perceptualPrecision: perceptualPrecision ?? defaultPerceptualPrecision,
                                            size: size(),
                                            traits: config.traits),
                           named: config.name,
                           record: recording,
                           file: file,
                           testName: testName,
                           line: line)
    }
}

public func assertSnapshots<VC: UIViewController>(configs: [SnapshotConfiguration] = [.default],
                                                  viewConfig: ViewImageConfig,
                                                  matching: @autoclosure () throws -> VC,
                                                  configure: (VC) -> VC = { $0 },
                                                  size: () -> CGSize,
                                                  precision: Float = 1,
                                                  perceptualPrecision: Float? = nil,
                                                  record recording: Bool = false,
                                                  file: StaticString = #file,
                                                  testName: String = #function,
                                                  line: UInt = #line) {
    for config in configs {
        try assertSnapshot(of: configure(matching()),
                           as: .customImage(on: viewConfig,
                                            precision: precision,
                                            perceptualPrecision: perceptualPrecision ?? defaultPerceptualPrecision,
                                            size: viewConfig.size ?? size(),
                                            traits: config.traits),
                           named: config.name,
                           record: recording,
                           file: file,
                           testName: testName,
                           line: line)
    }
}

public extension ViewImageConfig {
    static let iPhone14Pro = ViewImageConfig.iPhone14Pro(.portrait)

    static func iPhone14Pro(_ orientation: Orientation) -> ViewImageConfig {
        let safeArea: UIEdgeInsets
        let size: CGSize
        switch orientation {
        case .landscape:
            safeArea = .init(top: 0, left: 59, bottom: 21, right: 59)
            size = .init(width: 852, height: 393)
        case .portrait:
            safeArea = .init(top: 59, left: 0, bottom: 34, right: 0)
            size = .init(width: 393, height: 852)
        }

        return .init(safeArea: safeArea, size: size, traits: .iPhone14Pro(orientation))
    }
}

extension UITraitCollection {
    static func iPhone14Pro(_ orientation: ViewImageConfig.Orientation) -> UITraitCollection {
        let base: [UITraitCollection] = [
            .init(forceTouchCapability: .available),
            .init(layoutDirection: .leftToRight),
            .init(preferredContentSizeCategory: .medium),
            .init(userInterfaceIdiom: .phone),
        ]
        switch orientation {
        case .landscape:
            return .init(
                traitsFrom: base + [
                    .init(horizontalSizeClass: .regular),
                    .init(verticalSizeClass: .compact),
                ]
            )
        case .portrait:
            return .init(
                traitsFrom: base + [
                    .init(horizontalSizeClass: .compact),
                    .init(verticalSizeClass: .regular),
                ]
            )
        }
    }
}

