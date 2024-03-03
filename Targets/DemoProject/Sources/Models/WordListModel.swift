//
//  WordList.swift
//  LearnEnglish
//
//  Created by Dmitrii on 2/28/24.
//

import SwiftData
import Foundation


@Model
class WordListModel {
    var id: UUID
    var name: String
    var words: [WordModel]
    
    init(name: String,
        words: [WordModel]) {
        self.id = UUID()
        self.name = name
        self.words = words
    }
}
