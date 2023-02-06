//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by john-lim on 2023/01/31.
//

import UIKit

class MovieDetailViewController: UIViewController {
    private let movieTitle: String
    private let movieCode: String
    
    private let queueGroup = DispatchGroup()
    
    private lazy var movieDetailAPIProvider: APIProvider? = {
        guard let key = SecretKey.boxOfficeAPIKey else {
            return nil
        }
        let request = APIRequest.getMovieDetail(key: key, movieCode: self.movieCode)
        let apiProvider = APIProvider(request: request)
        return apiProvider
    }()
    
    private lazy var imageSearchAPIProvider: APIProvider? = {
        guard let key = SecretKey.daumKaKaoAPIKey else {
            return nil
        }
        let request = APIRequest.getDaumImageSearch(key: key, searchQuery: "\(self.movieTitle) 영화 포스터")
        let apiProvider = APIProvider(request: request)
        return apiProvider
    }()
    
    private let refresher = UIRefreshControl()
    
    private let scrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let detailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = CGFloat(5)
        return stackView
    }()
    
    private let posterImageView = DynamicFitImageView()
    
    private let directorStackView: MovieDetailRowStackView = MovieDetailRowStackView()
    private let productYearStackView: MovieDetailRowStackView = MovieDetailRowStackView()
    private let openYearStackView: MovieDetailRowStackView = MovieDetailRowStackView()
    private let showTimeStackView: MovieDetailRowStackView = MovieDetailRowStackView()
    private let watchGradeStackView: MovieDetailRowStackView = MovieDetailRowStackView()
    private let nationStackView: MovieDetailRowStackView = MovieDetailRowStackView()
    private let genreStackView: MovieDetailRowStackView = MovieDetailRowStackView()
    private let actorStackView: MovieDetailRowStackView = MovieDetailRowStackView()
    
    init(movieCode: String, movieTitle: String) {
        self.movieCode = movieCode
        self.movieTitle = movieTitle
        super.init(nibName: nil, bundle: nil)
        
        self.title = movieTitle
        self.view.backgroundColor = .white
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setHierarchy()
        self.setConstraint()
        self.setAttribute()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadData()
    }
    
    private func setHierarchy() {
        self.view.addSubview(self.scrollView)
        
        self.scrollView.addSubview(self.detailStackView)
        
        self.detailStackView.addArrangedSubview(self.posterImageView)
        [self.directorStackView,
         self.productYearStackView,
         self.openYearStackView,
         self.showTimeStackView,
         self.watchGradeStackView,
         self.nationStackView,
         self.genreStackView,
         self.actorStackView
        ].forEach { row in
            self.detailStackView.addArrangedSubview(row)
        }
    }
    
    private func setConstraint() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.scrollView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        self.scrollView.widthAnchor.constraint(equalTo: safeArea.widthAnchor).isActive = true
        self.scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        
        self.detailStackView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        self.detailStackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, constant: -20).isActive = true
        self.detailStackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.detailStackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        
        [self.directorStackView,
         self.productYearStackView,
         self.openYearStackView,
         self.showTimeStackView,
         self.watchGradeStackView,
         self.nationStackView,
         self.genreStackView,
         self.actorStackView
        ].forEach { row in
            row.setKeyLabelWidth(constraintAnchor: self.scrollView.widthAnchor, multiplier: 0.2)
        }
    }
    
    private func setAttribute() {
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.scrollView.refreshControl = self.refresher
    }
    
    @objc private func loadData() {
        Task {
            self.refresher.beginRefreshing()
            
            async let posterImage = loadImage()
            async let summary = loadDetailSummary()
            
            
            guard let image = await posterImage,
                let summary = await summary else {
                return
            }
            
            self.refresher.endRefreshing()
            posterImageView.image = image
            self.directorStackView.setText(key: summary.key(of: .director),
                                           value: summary.value(of: .director))
            self.productYearStackView.setText(key: summary.key(of: .productYear),
                                              value: summary.value(of: .productYear))
            self.openYearStackView.setText(key: summary.key(of: .openYear),
                                           value: summary.value(of: .openYear))
            self.showTimeStackView.setText(key: summary.key(of: .showTime),
                                           value: summary.value(of: .showTime))
            self.watchGradeStackView.setText(key: summary.key(of: .watchGrade),
                                             value: summary.value(of: .watchGrade))
            self.nationStackView.setText(key: summary.key(of: .productNation),
                                         value: summary.value(of: .productNation))
            self.genreStackView.setText(key: summary.key(of: .genre),
                                        value: summary.value(of: .genre))
            self.actorStackView.setText(key: summary.key(of: .actor),
                                        value: summary.value(of: .actor))
        }
    }
    
    private func loadDetailSummary() async -> MovieDetailSummary? {
        let result = await self.movieDetailAPIProvider?.startAsyncLoading().success()
        guard let data = result?.data,
              let summary = try? JSONDecoder().decode(MovieDetailResult.self, from: data).summary() else {
                  return nil
        }
        return summary
    }
    
    private func loadImage() async -> UIImage? {
        let result = await self.imageSearchAPIProvider?.startAsyncLoading().success()
        
        guard let data = result?.data,
              let result = try? JSONDecoder().decode(ImageSearchResult.self, from: data),
              let imageURLString = result.documents.first?.imageURL,
              let url = URL(string: imageURLString),
              let imageData = await dataWithContents(of: url) else {
                  return nil
        }
        
        return UIImage(data: imageData)
    }
    
    func dataWithContents(of url: URL) async -> Data? {
        async let data: Data? = Task.detached {
            if let data = NetworkCache.image.cachedResponse(for: URLRequest(url: url))?.data {
                return data
            }
            return try? Data(contentsOf: url)
        }.value
        
        guard let data = await data else {
            return nil
        }
        
        if let response = HTTPURLResponse(url: url, statusCode: 200,
                                          httpVersion: nil, headerFields: nil) {
            let cachedResponse = CachedURLResponse(response: response, data: data)
            NetworkCache.image.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
        }
        
        return data
    }
}
