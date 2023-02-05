//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class BoxOfficeListViewController: UIViewController {
    private let apiGroup = DispatchGroup()
    
    private enum Section: CaseIterable {
        case main
    }
    
    private let cellRegistration = UICollectionView.CellRegistration
    <BoxOfficeListCell, BoxOfficeSummary> { (cell, indexPath, data) in
        cell.setData(data)
    }
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, BoxOfficeSummary> = UICollectionViewDiffableDataSource<Section, BoxOfficeSummary>(collectionView: self.boxOfficeCollectionView) {
        (collectionView: UICollectionView, indexPath: IndexPath, identifier: BoxOfficeSummary) -> UICollectionViewCell? in
        return collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration, for: indexPath, item: identifier)
    }
    
    private let boxOfficeCollectionView: UICollectionView = {
        let heightDimension = NSCollectionLayoutDimension.estimated(50)
        
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
        collectionView.layer.borderColor = UIColor.systemGray4.cgColor
        collectionView.layer.borderWidth = 0.5
        return collectionView
    }()
    
    private let refresher: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setHierarchy()
        self.setConstraint()
        self.setAttribute()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
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
    
    private func setAttribute() {
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
        self.boxOfficeCollectionView.refreshControl = refresher
        self.boxOfficeCollectionView.delegate = self
    }
    
    @objc private func loadData() {
        self.refresher.beginRefreshing()
        
        let formatter = DateFormatter()
        let dashedYesterday = formatter.yesterday(format: DateFormat.dashed)
        let plainYesterday = formatter.yesterday(format: DateFormat.plain)
        
        guard let key = SecretKey.boxOfficeAPIKey else {
            return
        }
        let request = APIRequest
            .getDailyBoxOffice(key: key,
                               targetDate: plainYesterday)
        let apiProvider = APIProvider(request: request, queueGroup: apiGroup)
        
        var summarys: [BoxOfficeSummary]?
        apiProvider.startLoading { data, _, _ in
            if let data = data,
               let boxOfficeList = try? JSONDecoder().decode(DailyBoxOfficeSearchResult.self, from: data) {
                summarys = boxOfficeList.dailyList.map { boxOffice in
                    boxOffice.summary()
                }
            }
        }
        
        apiGroup.notify(queue: .main) {
            if let summarys = summarys {
                self.title = dashedYesterday
                
                self.refresher.endRefreshing()
                
                var snapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeSummary>()
                snapshot.appendSections([.main])
                snapshot.appendItems(summarys)
                self.dataSource.apply(snapshot, animatingDifferences: true)
            }
        }
    }
}

extension BoxOfficeListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let movieCode = self.dataSource.itemIdentifier(for: indexPath)?.movieCode,
           let movieTitle = self.dataSource.itemIdentifier(for: indexPath)?.title {
            
            self.navigationController?
                .pushViewController(MovieDetailViewController(movieCode: movieCode, movieTitle: movieTitle), animated: true)
        }
        
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
