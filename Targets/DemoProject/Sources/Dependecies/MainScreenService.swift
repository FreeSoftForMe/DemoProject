//
//  MainScreenService.swift
//  LearnEnglish
//
//  Created by Dmitrii on 2/29/24.
//

import SwiftData
import Foundation
import SwiftUI
import Dependencies


extension DependencyValues {
    var mainScreenService: MainScreenService {
        get { self[MainScreenService.self].self }
        set { self[MainScreenService.self].self = newValue }
    }
}

struct MainScreenService {
    var loadLists: @Sendable () throws -> [WordListModel]
    var deleteList: @Sendable (String) throws -> ()
}

extension MainScreenService: DependencyKey {
    static let liveValue: MainScreenService = .init {
        @Dependency(\.databaseService.context) var context
        do {
            let wordListContext = try context()
            let predicate = #Predicate<WordListModel>{ _ in true }
            let words: [WordListModel] = try wordListContext.fetch(.init())
            return words
        } catch {
            fatalError()
        }
    } deleteList: { listName in
        @Dependency(\.databaseService.context) var context
        do {
            let wordListContext = try context()
            let predicate = #Predicate<WordListModel>{ $0.name.localizedStandardContains(listName)  }
            try wordListContext.delete(model: WordListModel.self, where: predicate)
        } catch {
            fatalError()
        }
        
    }
}
