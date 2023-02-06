//
//  BoxofficeViewController.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/31.
//

import UIKit

fileprivate extension Date {
    static var yesterday: Date {
        return Date() - 24 * 3600
    }
}

class BoxofficeViewController: UIViewController {
    private let movieService: MovieService
    
    private var collectionView: UICollectionView!
    private var boxofficeDataSource: UICollectionViewDiffableDataSource<Int, BoxofficeRecode>?
    private var boxofficeSnapshot = NSDiffableDataSourceSnapshot<Int, BoxofficeRecode>()
    private let refreshControl = UIRefreshControl()
    private let loadingIndicator = UIActivityIndicatorView()
    
    init(movieService: MovieService) {
        self.movieService = movieService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.configureCollectionView()
        self.boxofficeDataSource = self.createDataSource()
        self.configureSnapshot()
        self.configureHierarchy()
        self.configureConstraint()
        self.configureRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchBoxOffice(for: .yesterday)
    }

    private func configureHierarchy() {
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.loadingIndicator)
    }
    
    private func configureConstraint() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
        ])
    }

    private func configureCollectionView() {
        let layout = self.createCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        self.collectionView = collectionView
    }
    
    private func configureRefreshControl() {
        self.collectionView.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }

    @objc
    private func refresh() {
        self.fetchBoxOffice(for: .yesterday)
    }

    private func configureSnapshot() {
        self.boxofficeSnapshot.appendSections([0])
    }
    
    private func updateSnapshot(items: [BoxofficeRecode]) {
        let currentItems = self.boxofficeSnapshot.itemIdentifiers(inSection: 0)
        self.boxofficeSnapshot.deleteItems(currentItems)
        self.boxofficeSnapshot.appendItems(items, toSection: 0)
        self.boxofficeDataSource?.apply(self.boxofficeSnapshot)
    }
    
    private func createDataSource() -> UICollectionViewDiffableDataSource<Int, BoxofficeRecode> {
        let cellRegistration = self.createCellRegistration()
        return UICollectionViewDiffableDataSource(
            collectionView: self.collectionView
        ) { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier
            )
        }
    }
    
    private func createCellRegistration() -> UICollectionView.CellRegistration<UICollectionViewListCell, BoxofficeRecode> {
        return UICollectionView.CellRegistration<UICollectionViewListCell, BoxofficeRecode> { cell, indexPath, itemIdentifier in
            var configuration = BoxofficeListContentView.Configuration()

            configuration.recode = itemIdentifier
            
            cell.contentConfiguration = configuration
        }
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.showsSeparators = true
        configuration.backgroundColor = .white
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func fetchBoxOffice(for date: Date) {
        self.collectionView.refreshControl?.beginRefreshing()
        self.movieService.fetchBoxoffice(
            date: date,
            itemPerPage: nil,
            movieType: nil,
            nationType: nil,
            areaCode: nil
        ) { result in
            switch result {
            case .success(let boxoffice):
                DispatchQueue.main.async {
                    self.title = DateFormatter.yearMonthDayWithDash.string(from: boxoffice.date)
                    self.updateSnapshot(items: boxoffice.boxofficeRecodes)
                    self.collectionView.refreshControl?.endRefreshing()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
