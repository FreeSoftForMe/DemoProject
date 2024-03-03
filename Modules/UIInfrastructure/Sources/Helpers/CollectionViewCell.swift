//
//  File.swift
//  UI
//
//  Created by Dmitrii on 3/2/24.
//

import UIKit
import PinLayout

//TODO: add documentation
public protocol ContentView: UIView {
    func prepareForReuse()
}

public final class CollectionViewCell<T: ContentView>: UICollectionViewCell {
    private weak var content: T?
    
    func setupContentIfNeeded(_ block : @autoclosure() -> T) {
        guard content == nil else { return }
        let view = block()
        addSubview(view)
        content = view
    }
    
    func configure(_ block: (T) -> ()) {
        guard let content else {
            assertionFailure("content didn't setup")
            return
        }
        block(content)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        content?.pin
            .all()
    }
}

public extension UICollectionViewCell {
    static var identifier: String {
        String(describing: Self.self)
    }
}
