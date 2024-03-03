//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by Dmitrii on 3/2/24.
//

import ProjectDescription

public let modules: [TargetDependency] = [
    module(name: "Interfaces"),
    feature(name: "MainScreenFeature"),
]

public let thirdParty: [TargetDependency] = [
    .external(name: "Swinject"),
    
]
