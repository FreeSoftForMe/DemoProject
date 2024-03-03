//
//  Props.swift
//  MainScreenFeature
//
//  Created by Dmitrii on 3/3/24.
//

import UIComponents
import Common
import UIKit


struct Props: Hashable {
    let onViewAppear: Command<Void>
    let collectionData: CollectionData
    let style: Style
    let metrics: Metrics
    
    public init(onViewAppear: Command<Void>,
                collectionData: CollectionData,
                style: Style = .default,
                metrics: Metrics = .init()) {
        self.onViewAppear = onViewAppear
        self.collectionData = collectionData
        self.style = style
        self.metrics = metrics
    }
    
    struct CollectionData: Hashable {
        let sections: [Section]
        struct Section: Hashable, Identifiable {
            //TODO: Change to correct id
            let id: UUID = .init()
            let cells: [TextIconView.Props]
        }
        
        static let empty: Self = .init(sections: [])
    }
    
    public static let empty: Self = .init(onViewAppear: .empty,
                                          collectionData: .empty)
}

struct Style: Hashable {
    let background: UIColor
    let tableColor: UIColor
    
    public static let `default`: Self = .init(background: .white,
                                       tableColor: .white)
}

struct Metrics: Hashable {
    public init() {}
}
