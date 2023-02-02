//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class BoxOfficeListViewController: UIViewController {
    private enum Section {
        case main
    }
    
    private lazy var refreshBoxOfficeList: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshCollectionView), for: .valueChanged)
        
        return refreshControl
    }()
    private let activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        
        return activityView
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: self.createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.refreshControl = self.refreshBoxOfficeList
        
        return collectionView
    }()
    private var dataSource: UICollectionViewDiffableDataSource<Section,
                                                               BoxOfficeItem>?
    private var items: [BoxOfficeItem] = []
    private let networkService: NetworkServiceProtocol? = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAttribute()
        configureConstraints()
        configureDataSource()
        loadData { [weak self] in
            DispatchQueue.main.async {
                self?.activityView.stopAnimating()
            }
        }
    }
    
    private func loadData(_ completion: @escaping () -> Void) {
        networkService?.fetch(searchTarget: .searchDailyBoxOffice,
                              headers: nil,
                              queryItems: [QueryKeys.targetDate: Date
                                .dayString(.yesterday,format: .yyyyMMdd)]) {
            [weak self] (response: Result<BoxOfficeSearchResult, NetworkServiceError>) -> Void in
            switch response {
            case .success(let data):
                self?.items = data.result.dailyList.map { dailyItem in
                    return BoxOfficeItem(dailyItem)
                }
                self?.updateUI()
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc private func refreshCollectionView() {
        loadData { [weak self] in
            DispatchQueue.main.async {
                self?.refreshBoxOfficeList.endRefreshing()
            }
        }
    }
}

extension BoxOfficeListViewController {
    private func createLayout() -> UICollectionViewLayout {
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
    
    private func configureAttribute() {
        activityView.startAnimating()
        title = Date.dayString(.yesterday, format: .yyyy_MM_dd)
    }
    
    private func configureConstraints() {
        [collectionView, activityView].forEach { subview in
            view.addSubview(subview)
        }
        
        NSLayoutConstraint.activate([
            activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView
            .CellRegistration<BoxOfficeListCell,
                              BoxOfficeItem> {
                                  (cell, indexPath, newItem) in
                                  cell
                                      .fillContents(newItem: newItem)
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
    
    private func updateUI() {
        var snapShot = NSDiffableDataSourceSnapshot<Section,
                                                    BoxOfficeItem>()
        snapShot.appendSections([.main])
        snapShot.appendItems(items)
        dataSource?.apply(snapShot, animatingDifferences: false)
    }
}
