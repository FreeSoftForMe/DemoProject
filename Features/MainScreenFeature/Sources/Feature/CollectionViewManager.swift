//
//  MainScreenTableViewManager.swift
//  MainScreenFeature
//
//  Created by Dmitrii on 3/3/24.
//

import UIKit
import UIComponents
import UIInfrastructure

final class CollectionViewManager: NSObject, UICollectionViewDelegateFlowLayout {
    typealias CollectionData = Props.CollectionData
    typealias Section = CollectionData.Section
    typealias Cell = TextIconView.Props
    private let collectionView: UICollectionView
    private var diffableDataSource: UICollectionViewDiffableDataSource<Section, Cell>?
    var collectionData: Props.CollectionData = .empty {
        didSet {
            applySnapshot()
        }
    }
    
    private func applySnapshot() {
        //TODO: Make helper for NSDiffableDataSourceSnapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Cell>()
        snapshot.appendSections(collectionData.sections)
        collectionData.sections.forEach {
            snapshot.appendItems($0.cells, toSection: $0)
        }
        diffableDataSource?.apply(snapshot)
    }
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        commonInit()
    }
    
    private func commonInit() {
        collectionView.registerCell(CollectionViewCell<TextIconView>.self)
        //TODO: Make helper for UICollectionViewDiffableDataSource
        diffableDataSource = UICollectionViewDiffableDataSource<Section, Cell>.init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueReusableCell(CollectionViewCell<TextIconView>.self, for: indexPath) {
                TextIconView()
            } configure: {
                $0.props = itemIdentifier
            }
        }
        
        collectionView.dataSource = diffableDataSource
        collectionView.delegate = self
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let props = collectionData.sections[indexPath.section].cells[indexPath.row]
        let collectionSize = collectionView.frame.size
        let height = TextIconView.size(for: collectionSize, props: props).height
        return CGSize(width: collectionSize.width, height: height)
    }
}
