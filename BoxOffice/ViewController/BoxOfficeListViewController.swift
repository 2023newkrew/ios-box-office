//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class BoxOfficeListViewController: UIViewController {
    private enum DateFormat {
        static let title = "yyyy-MM-dd"
        static let target = "yyyyMMdd"
    }
    
    private enum Section: CaseIterable {
        case main
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, BoxOfficeSummary>?
    
    private let boxOfficeCollectionView: UICollectionView = {
        let heightDimension = NSCollectionLayoutDimension.estimated(100)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: heightDimension)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        let customLayout = UICollectionViewCompositionalLayout(section: section)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: customLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let refresher: UIRefreshControl = {
        let refresh = UIRefreshControl()
        return refresh
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDataSource()
        self.setHierarchy()
        self.setConstraint()
        self.setAttribute()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }
    
    private func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration
        <BoxOfficeListCell, BoxOfficeSummary> { (cell, indexPath, data) in
            cell.setData(data)
        }
        self.dataSource = UICollectionViewDiffableDataSource<Section, BoxOfficeSummary>(collectionView: self.boxOfficeCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: BoxOfficeSummary) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
    }
    
    private func setHierarchy() {
        self.view.addSubview(self.boxOfficeCollectionView)
    }
    
    private func setConstraint() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.boxOfficeCollectionView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        self.boxOfficeCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        self.boxOfficeCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        self.boxOfficeCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
    
    private func setAttribute(){
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.boxOfficeCollectionView.refreshControl = refresher
        self.boxOfficeCollectionView.delegate = self
    }
    
    @objc private func loadData() {
        self.refresher.beginRefreshing()
        
        let formatter = DateFormatter()
        self.title = formatter.yesterday(format: DateFormat.title)
        
        guard let key = SecretKey.boxOfficeAPIKey else {
            return
        }
        let request = APIRequest
            .getDailyBoxOffice(key: key,
                               targetDate: formatter.yesterday(format: DateFormat.target))
        let apiProvider = APIProvider(request: request)
        
        apiProvider.startLoading { data, _, _ in
            guard let data = data else {
                return
            }
            guard let boxOfficeList = try? JSONDecoder().decode(DailyBoxOfficeSearchResult.self, from: data) else {
                return
            }
            
            DispatchQueue.main.async {
                let summarys = boxOfficeList.dailyList.map { boxOffice in
                    boxOffice.summary()
                }
                
                var snapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeSummary>()
                snapshot.appendSections([.main])
                snapshot.appendItems(summarys)
                
                if let dataSource  = self.dataSource {
                    dataSource.apply(snapshot, animatingDifferences: true)
                }
                self.refresher.endRefreshing()
            }
        }
    }
}

extension BoxOfficeListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.boxOfficeCollectionView.deselectItem(at: indexPath, animated: true)
    }
}

private extension DateFormatter {
    func yesterday(format: String) -> String {
        self.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        self.dateFormat = format
        return self.string(from: Date(timeIntervalSinceNow: -86400))
    }
}
