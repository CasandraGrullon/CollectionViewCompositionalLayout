//
//  ViewController.swift
//  CollectionViewCompositionalLayout
//
//  Created by casandra grullon on 8/17/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class GridViewController: UIViewController {

    enum Section {
        case main
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    //by default, the collection view default layout type is flow layout
    //we need to programatically set it to compositional layout
    private func configureCollectionView() {
        //compostional layout using storyboards
        collectionView.collectionViewLayout = createLayout()
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = dataSource
        //compositional layout programatically
        //collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
    }
    private func createLayout() -> UICollectionViewLayout {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        
        //layout
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "labelCell", for: indexPath) as? LabelCell else {
                fatalError("could not dequeue LabelCell")
            }
            cell.textLabel.text = "\(item)"
            return cell
        })
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(1...100))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

