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
    private var dataSource: UICollectionViewDiffableDataSource<Section,
                                                               BoxOfficeItem>?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
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
    
    func configureHierarchy() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView
            .CellRegistration<BoxOfficeListCell,
                              BoxOfficeItem> {
                                  (cell, indexPath, newItem) in
                                  cell.titleLabel.text = newItem.title
                                  cell.rankLabel.text = newItem.rank
                                  cell.rankDescriptionLabel
                                      .attributedText = newItem.rankDescription
                                  cell.showCountLabel.text = newItem.showCountInformation
                                  cell.showsSeparator = true
                              }
        
        dataSource = UICollectionViewDiffableDataSource
        <Section,
         BoxOfficeItem>(collectionView: collectionView) {
             (collectionView: UICollectionView,
              indexPath: IndexPath,
              item: BoxOfficeItem) -> UICollectionViewCell? in
             return collectionView
                 .dequeueConfiguredReusableCell(using: cellRegistration,
                                                for: indexPath,
                                                item: item)
         }
    }
}

