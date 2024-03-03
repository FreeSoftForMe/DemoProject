//
//  MainScreenViewController.swift
//  MainScreenFeature
//
//  Created by Dmitrii on 3/3/24.
//


import UIKit
import UIComponents
import Interfaces
import Common
import ComposableArchitecture
import Combine


final class ViewController: UIViewController, MainScreenInput {
    private let collectionView: UICollectionView
    private let collectionViewManager: CollectionViewManager
    private let propsBuilder: PropsBuilder
    private let store: StoreOf<Feature>
    private var cancellable: AnyCancellable?
    private var props: Props = .empty {
        didSet {
            collectionViewManager.collectionData = props.collectionData
        }
    }
    
    init(propsBuilder: PropsBuilder,
                store: StoreOf<Feature>) {
        //TODO: Make function to make UICollectionViewFlowLayout and solve problem with zero size
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        self.collectionViewManager = .init(collectionView: collectionView)
        self.propsBuilder = propsBuilder
        self.store = store
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    private func commonInit() {
        view.addSubview(collectionView)
        cancellable = store.publisher
            .compactMap { [weak self] state in self?.propsBuilder.buildProps(state: state) }
            .sink(receiveValue: { [weak self] props in self?.props = props })
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.pin
            .all()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        props.onViewAppear()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
