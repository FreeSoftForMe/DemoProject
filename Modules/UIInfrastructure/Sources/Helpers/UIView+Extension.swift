//
//  UIView+Extension.swift
//  UI
//
//  Created by Dmitrii on 3/2/24.
//

import UIKit

//TODO: add docuemntation
public extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach(addSubview(_:))
    }
    
    func resetViewFrame() {
        frame = .zero
        subviews.forEach { $0.resetViewFrame() }
    }
}
