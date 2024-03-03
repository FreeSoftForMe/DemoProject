//
//  Reducer.swift
//  MainScreenFeature
//
//  Created by Dmitrii on 3/3/24.
//

import ComposableArchitecture

@Reducer
final class Feature {
    
    struct State: Equatable {
        var cells: [String] = []
    }
    
    enum Action: Equatable {
        case onViewWillAppear
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onViewWillAppear:
                state.cells = ["Hello", "Hey", "Hell"]
                return .none
            }
        }
    }
}
