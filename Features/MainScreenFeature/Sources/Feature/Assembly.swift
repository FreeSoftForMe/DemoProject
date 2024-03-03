//
//  Assembly.swift
//  MainScreenFeature
//
//  Created by Dmitrii on 3/3/24.
//

import Swinject
import ComposableArchitecture
import Common
import Interfaces

public final class MainScreenAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(Feature.self) { _ in
            Feature()
        }
        
        container.register(StoreOf<Feature>.self) { r in
            let feature = r.resolve(Feature.self)!
            return Store(initialState: .init()) {
                feature
            }
        }
        
        container.register(PropsBuilder.self) { (_, store:StoreOf<Feature>)  in
            PropsBuilder(store: store)
        }
        
        container.register(MainScreenInput.self) { r in
            let store = r.resolve(StoreOf<Feature>.self)!
            let propsBuilder = r.resolve(PropsBuilder.self, argument: store)!
            return ViewController(propsBuilder: propsBuilder,
                                  store: store)
        }
    }
}
