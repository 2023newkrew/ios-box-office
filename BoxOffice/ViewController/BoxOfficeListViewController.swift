//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class BoxOfficeListViewController: UIViewController {
    enum Section: CaseIterable {
        case main
    }
    
    var targetDate: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        formatter.dateFormat = "yyyyMMdd"
        return formatter.string(from: Date(timeIntervalSinceNow: -86400))
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, BoxOfficeSummary>?
    
    let boxOfficeCollectionView: UICollectionView = {
        let heightDimension = NSCollectionLayoutDimension.estimated(500)
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
    
    let refresher: UIRefreshControl = {
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
        
        self.dataSource = UICollectionViewDiffableDataSource<Section, BoxOfficeSummary>(collectionView: boxOfficeCollectionView) {
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
    
    @objc func loadData() {
        self.refresher.beginRefreshing()
        
        let yesterday = self.targetDate
        self.title = yesterday.titleFormat()
        
        guard let key = SecretKey.boxOfficeAPIKey else {
            return
        }
        let request = APIRequest.getDailyBoxOffice(key: key, targetDate: yesterday)
        let apiProvider = APIProvider(request: request)
        
        apiProvider.startLoading { data, _, _ in
            guard let data = data else {
                print("data nil")
                return
            }
            guard let boxOfficeList = try? JSONDecoder().decode(DailyBoxOfficeSearchResult.self, from: data) else {
                print("boxOfficeList nil")
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
        print("hello")
        self.boxOfficeCollectionView.deselectItem(at: indexPath, animated: true)
    }
}

private extension String {
    func substring(from: Int, to: Int) -> String {
            guard from < count, to >= 0, to - from >= 0 else {
                return ""
            }
            let startIndex = index(self.startIndex, offsetBy: from)
            let endIndex = index(self.startIndex, offsetBy: to + 1)
            return String(self[startIndex ..< endIndex])
        }
    
    func titleFormat() -> String {
        guard self.count == 8 else {
            return self
        }
        let year = self.substring(from: 0, to: 3)
        let month = self.substring(from: 4, to: 5)
        let day = self.substring(from: 6, to: 7)
        return "\(year)-\(month)-\(day)"
    }
}
