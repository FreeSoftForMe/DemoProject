//
//  CoreDataService.swift
//  LearnEnglish
//
//  Created by Dmitrii on 2/28/24.
//

import SwiftData
import Foundation
import SwiftUI
import Dependencies


extension DependencyValues {
    var wordService: WordDatabase {
        get { self[WordDatabase.self] }
        set { self[WordDatabase.self] = newValue }
    }
}

struct WordDatabase {
    var fetch: @Sendable (FetchDescriptor<WordListModel>) throws -> WordListModel
    var add: @Sendable (WordModel) throws -> ()
    var delete: @Sendable (WordModel) throws -> ()
    
    enum WordError: Error {
        case add
        case delete
        case fetchError
    }
}

extension WordDatabase: DependencyKey {
    static let liveValue: Self = .init
    { descriptor in
        do {
            @Dependency(\.databaseService.context) var context
            let wordContext = try context()
            guard let words = try wordContext.fetch(descriptor).first else { throw WordError.fetchError }
            return words
        } catch {
            throw WordError.fetchError
        }
    } add: { model in
        do {
            @Dependency(\.databaseService.context) var context
            let wordContext = try context()
            wordContext.insert(model)
        } catch {
            throw WordError.add
        }
    } delete: { model in
        do {
            @Dependency(\.databaseService.context) var context
            let wordContext = try context()
            wordContext.delete(model)
        } catch {
            throw WordError.delete
        }
    }
}
