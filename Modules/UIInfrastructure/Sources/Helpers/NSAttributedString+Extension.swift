//
//  NSAtributesString+Extension.swift
//  UI
//
//  Created by Dmitrii on 3/2/24.
//

import UIKit

//TODO: add documentation
public extension NSAttributedString {
    var estimatedSize: CGSize {
        estimatedSizeFor(size: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
    }

    func estimatedSizeFor(width: CGFloat) -> CGSize {
        estimatedSizeFor(size: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
    }

    func estimatedSizeFor(width: CGFloat, rowsCountLimit: Int) -> CGSize {
        guard length > 0 else { return .zero }

        let lineHeight: CGFloat = {
            guard let font = attribute(NSAttributedString.Key.font, at: 0, effectiveRange: nil) as? UIFont else { return .zero }
            return font.lineHeight
        }()
        guard rowsCountLimit > 0 else { return estimatedSizeFor(width: width) }
        guard rowsCountLimit > 1 else { return .init(width: width, height: lineHeight) }
        let rowsString = String(repeating: "\n", count: rowsCountLimit - 1)
        let rowsAttributedString = NSMutableAttributedString(string: rowsString)
        let attributes = attributes(at: 0, effectiveRange: nil)
        rowsAttributedString.addAttributes(attributes, range: NSRange(location: 0, length: rowsString.count))
        let originalSize = estimatedSizeFor(width: width)
        let limitSize = rowsAttributedString.estimatedSizeFor(width: width)
        return .init(width: width, height: min(originalSize.height, limitSize.height))
    }

    func estimatedSizeFor(height: CGFloat) -> CGSize {
        estimatedSizeFor(size: CGSize(width: CGFloat.greatestFiniteMagnitude, height: height))
    }

    func estimatedSizeFor(size: CGSize) -> CGSize {
        guard size != .zero else { return .zero }
        guard length > 0 else { return .zero }

        let boundingRect = self.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil)
        return CGSize(width: ceil(min(size.width, boundingRect.width)), height: min(size.height, boundingRect.height))
    }
}
