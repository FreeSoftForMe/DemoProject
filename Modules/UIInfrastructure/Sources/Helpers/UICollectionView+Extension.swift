//
//  UITableView+Extension.swift
//  UI
//
//  Created by Dmitrii on 3/2/24.
//

import UIKit

//TODO: add documentation
public extension UICollectionView {
    func dequeueReusableCell<T>(_ cellType: CollectionViewCell<T>.Type,
                                for indexPath: IndexPath,
                                setupContentIfNeeded: () -> T,
                                configure: (T) -> ()) -> CollectionViewCell<T>  {
        guard let cell = dequeueReusableCell(withReuseIdentifier: CollectionViewCell<T>.identifier, for: indexPath) as? CollectionViewCell<T> else {
            fatalError("can't get cell")
        }
        cell.setupContentIfNeeded(setupContentIfNeeded())
        cell.configure(configure)
        return cell
    }
    
    func registerCell(_ cell: UICollectionViewCell.Type) {
        register(cell, forCellWithReuseIdentifier: cell.identifier)
    }
}
