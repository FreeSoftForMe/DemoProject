//
//  String+Extension.swift
//  UI
//
//  Created by Dmitrii on 3/2/24.
//

import Foundation

//TODO: add documentation
public extension String {
    func attributedString(_ style: TextStyle) -> NSAttributedString {
        NSAttributedString(string: self, attributes: style.attributes)
    }
}
