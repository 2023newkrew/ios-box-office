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
        self.refresher.beginRefreshing()
        Task {
            async let posterImage = loadImage()
            async let summary = NetworkService.movieDetailSummary(of: self.movieCode)
            
            
            guard let image = await posterImage,
                  let summary = await summary else {
                return
            }
            self.refresher.endRefreshing()
            self.updateUI(image: image, summary: summary)
        }
    }
    
    private func loadImage() async -> UIImage? {
        guard let imageURL = await NetworkService.searchImageURL(of: "\(self.movieTitle) 영화 포스터"),
              let imageData = await NetworkService.loadData(from: imageURL) else {
            return nil
        }
        return UIImage(data: imageData)
    }
    
    private func updateUI(image: UIImage, summary: MovieDetailSummary) {
        self.posterImageView.image = image
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
