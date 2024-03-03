//
//  WordModel.swift
//  LearnEnglish
//
//  Created by Dmitrii on 2/28/24.
//

import SwiftData
import Foundation

@Model
class WordModel: Comparable, CustomStringConvertible {
    var id: UUID = UUID()
    var word: String
    var translation: String
    
    init(word: String, translation: String) {
        self.word = word
        self.translation = translation
    }
    
    var description: String {
        """
            word: \(word)
            translation: \(translation)
        """
    }
    
    static func < (lhs: WordModel, rhs: WordModel) -> Bool {
        lhs.word < rhs.word
    }
}
