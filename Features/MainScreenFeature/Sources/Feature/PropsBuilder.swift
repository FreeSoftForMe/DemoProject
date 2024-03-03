//
//  PropsBuilder.swift
//  MainScreenFeature
//
//  Created by Dmitrii on 3/3/24.
//

import ComposableArchitecture
import Common
import Combine
import Interfaces
import UIComponents

final class PropsBuilder {
    private let store: StoreOf<Feature>
    init(store: StoreOf<Feature>) {
        self.store = store
    }
    
    func buildProps(state: Feature.State) -> Props {
        let cells: [TextIconView.Props] = state.cells.map { .init(title: $0) }
        let onViewAppear: Command<Void> = .init { [weak store] _ in
            store?.send(.onViewWillAppear)
        }
        return .init(onViewAppear: onViewAppear,
                     collectionData: .init(sections: [.init(cells: cells)]))
    }
}
