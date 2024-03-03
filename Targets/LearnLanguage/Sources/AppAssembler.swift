//
//  MainAssembler.swift
//  LearnLanguages
//
//  Created by Dmitrii on 3/3/24.
//

import Swinject
import Interfaces
import MainScreenFeature
import Core

enum AppAssembler {
    static let mainAssembler: Assembler = {
        let assemblies: [Assembly] = [
            MainScreenAssembly()
        ]
        return .init(assemblies, parent: Assembler(container: CoreContainer))
    }()
}
