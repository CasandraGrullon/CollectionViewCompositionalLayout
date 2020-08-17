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
        configureDataSource()
    }
    //by default, the collection view default layout type is flow layout
    //we need to programatically set it to compositional layout
    private func configureCollectionView() {
        //compostional layout using storyboards
        collectionView.collectionViewLayout = createLayout()
        collectionView.backgroundColor = .systemBackground
        
        //compositional layout programatically
        //collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
    }
    private func createLayout() -> UICollectionViewLayout {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.25))
        //let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
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
            cell.backgroundColor = .systemPink
            return cell
        })
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(1...100))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

