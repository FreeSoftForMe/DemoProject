//
//  AddListScreenService.swift
//  LearnEnglish
//
//  Created by Dmitrii on 2/29/24.
//

import Dependencies
import SwiftData


extension DependencyValues {
    var addListService: AddListScreenService {
        get { self[AddListScreenService.self].self }
        set { self[AddListScreenService.self].self = newValue }
    }
}

struct AddListScreenService {
    var save: @Sendable (WordListModel) throws -> Void
    var edit: @Sendable (WordListModel) throws -> Void
}

extension AddListScreenService: DependencyKey {
    enum AddListScreenServiceError: Error {
        case save
        case edit
    }
    
    static let liveValue: AddListScreenService = .init {
        @Dependency(\.databaseService.context) var context
        do {
            let wordContext = try context()
            wordContext.insert($0)
        } catch {
            throw AddListScreenServiceError.save
        }
    } edit: {
        @Dependency(\.databaseService.context) var context
        do {
            let wordContext = try context()
            wordContext.insert($0)
        } catch {
            throw AddListScreenServiceError.save
        }
    }

}
