//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class BoxOfficeListViewController: UIViewController {
    enum Section {
        case main
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: self.createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BoxOfficeListViewController {
    func createLayout() -> UICollectionViewLayout {
        let estimatedHeight = CGFloat(100)
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(estimatedHeight))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize,
                                                       subitem: item,
                                                       count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                        leading: 10,
                                                        bottom: 10,
                                                        trailing: 10)
        section.interGroupSpacing = 10
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

