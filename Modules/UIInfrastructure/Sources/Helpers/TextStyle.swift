//
//  TextStyle.swift
//  UI
//
//  Created by Dmitrii on 3/2/24.
//

import Common
import UIKit

//TODO: add documentation
public struct TextStyle: Hashable {
    public var font: UIFont
    public var lineHeight: CGFloat?
    public var textColor: UIColor
    public var letterSpacing: CGFloat
    public var lineSpacing: CGFloat
    public var paragraphSpacing: CGFloat
    public var alignment: NSTextAlignment
    public var baselineOffset: CGFloat
    public var headIndent: CGFloat
    public var strikethroughStyle: NSUnderlineStyle?
    public var lineBreakingMode: NSLineBreakMode?
    public var kern: NSNumber?
    
    public var attributes: [NSAttributedString.Key: Any] {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = lineSpacing
        paragraph.paragraphSpacing = paragraphSpacing
        paragraph.alignment = alignment
        paragraph.headIndent = headIndent
        if let lineHeight = lineHeight {
            paragraph.maximumLineHeight = lineHeight
            paragraph.minimumLineHeight = lineHeight
        }
        
        if let lineBreakingMode {
            paragraph.lineBreakMode = lineBreakingMode
        }
        
        var otherAttributes = [NSAttributedString.Key: Any]()
        if let strikethroughStyle = strikethroughStyle {
            otherAttributes.merge([.strikethroughStyle: strikethroughStyle.rawValue]) { $1 }
        }
        if let kern {
            otherAttributes.merge([.kern: kern]) { $1 }
        }
        
        return [
            .paragraphStyle: paragraph,
            .foregroundColor: textColor,
            .kern: letterSpacing,
            .font: font,
            .baselineOffset: baselineOffset,
        ].merging(otherAttributes) { $1 }
    }
    
    init(font: UIFont,
         lineHeight: CGFloat? = nil,
         textColor: UIColor,
         letterSpacing: CGFloat = 0,
         lineSpacing: CGFloat = 0,
         paragraphSpacing: CGFloat = 0,
         alignment: NSTextAlignment = .left,
         baseline: CGFloat = 0,
         headIndent: CGFloat = 0,
         strikethroughStyle: NSUnderlineStyle? = nil,
         lineBreakingMode: NSLineBreakMode? = nil,
         kern: NSNumber? = nil) {
        self.font = font
        self.lineHeight = lineHeight
        self.textColor = textColor
        self.letterSpacing = letterSpacing
        self.lineSpacing = lineSpacing
        self.paragraphSpacing = paragraphSpacing
        self.alignment = alignment
        self.baselineOffset = baseline
        self.strikethroughStyle = strikethroughStyle
        self.headIndent = headIndent
        self.lineBreakingMode = lineBreakingMode
        self.kern = kern
    }
    
    
    public static let largeTitle: Self = .init(font: .systemFont(ofSize: 28, weight: .bold), textColor: .black)
    public static let mediumTitle: Self = .init(font: .systemFont(ofSize: 24, weight: .medium), textColor: .black)
    public static let smallTitle: Self = .init(font: .systemFont(ofSize: 20, weight: .regular), textColor: .black)
    public static let text: Self = .init(font: .systemFont(ofSize: 16, weight: .regular), textColor: .black)
}

extension TextStyle: DSLCompatible {}
