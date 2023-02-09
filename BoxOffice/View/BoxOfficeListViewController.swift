//
//  ViewController.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import UIKit

enum Section: CaseIterable {
    case main
}

class BoxOfficeListViewController: UIViewController {
    
    @IBOutlet private weak var navigationBar: UINavigationBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, DailyMovie>!
    
    private var refreshControl: UIRefreshControl?
    private var loadingView: LoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureLoadingView()
        
        self.configureNavigationBar()
        self.configureRefreshControl()
        self.configureCollectionView()
        self.configureDataSource()
        self.refresh()
    }
    
}

extension BoxOfficeListViewController {
    private func configureLoadingView() {
        self.loadingView = LoadingView()
        self.view.addSubview(self.loadingView)
        
        self.loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [weak self] in
            self?.loadingView.removeFromSuperview()
        })
    }
    
    private func configureNavigationBar() {
        self.navigationBar.topItem?.title = Day.today.formattedDate
    }
    
    private func configureRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        self.collectionView.refreshControl = self.refreshControl
    }
    
    private func configureCollectionView() {
        self.collectionView.collectionViewLayout = createLayout()
    }
    
    @objc private func refresh() {
        self.perform() { result in
            switch result {
            case true:
                DispatchQueue.main.async {
                    self.refreshControl?.endRefreshing()
                }
            case false:
                self.refresh()
            }
        }
    }
}

extension BoxOfficeListViewController {
    private func configureDataSource() {
        self.collectionView.register(BoxOfficeListCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.dataSource = UICollectionViewDiffableDataSource<Section, DailyMovie>(collectionView: self.collectionView) { (collectionView, indexPath, dailyMovie) -> BoxOfficeListCollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? BoxOfficeListCollectionViewCell else {
                preconditionFailure() }
            cell.configureCell(with: dailyMovie)
            return cell
        }
    }
    
    private func perform(completion: @escaping (Bool) -> Void) {
        let networkManager = NetworkManager()
        let url = networkManager.apiURL(api: API.dailyBoxOffice, yyyyMMdd: Day.yesterday.formattedDate)
        let decoder = JSONDecoder()
        networkManager.load(url: url) { data in
            switch data {
            case .success(let result):
                do {
                    let dailyBoxOffice = try decoder.decode(DailyBoxOffice.self, from: Data(result.utf8))
                    var snapshot = NSDiffableDataSourceSnapshot<Section, DailyMovie>()
                    snapshot.appendSections([.main])
                    snapshot.appendItems(dailyBoxOffice.information.movieList)
                    self.dataSource.apply(snapshot, animatingDifferences: true)
                    return completion(true)
                } catch {
                    return completion(false)
                }
            case .failure(let error):
                print(error)
                return completion(false)
            }
        }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.showsSeparators = true
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
}
