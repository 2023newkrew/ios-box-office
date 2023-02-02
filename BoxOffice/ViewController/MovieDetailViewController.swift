//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by john-lim on 2023/01/31.
//

import UIKit

class MovieDetailViewController: UIViewController {
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
        return stackView
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let directorStackView: MovieDetailRowStackView = MovieDetailRowStackView()
    private let productYearStackView: MovieDetailRowStackView = MovieDetailRowStackView()
    private let openYearStackView: MovieDetailRowStackView = MovieDetailRowStackView()
    private let showTimeStackView: MovieDetailRowStackView = MovieDetailRowStackView()
    private let watchGradeStackView: MovieDetailRowStackView = MovieDetailRowStackView()
    private let nationStackView: MovieDetailRowStackView = MovieDetailRowStackView()
    private let genreStackView: MovieDetailRowStackView = MovieDetailRowStackView()
    private let actorStackView: MovieDetailRowStackView = MovieDetailRowStackView()
    
    init(movieCode: String){
        self.movieCode = movieCode
        super.init(nibName: nil, bundle: nil)
        
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
        
        posterImageView.image = UIImage(named: "SampleImage")
        
        guard let key = SecretKey.boxOfficeAPIKey else {
            return
        }
        let request = APIRequest.getMovieDetail(key: key, movieCode: self.movieCode)
        
        let apiProvider = APIProvider(request: request)
        
        apiProvider.startLoading { data, _, _ in
            DispatchQueue.main.async {
                self.refresher.endRefreshing()
                if let data = data,
                   let detail = try? JSONDecoder().decode(MovieDetailResult.self, from: data).summary() {
                    self.title = detail.value(of: .title)
                    self.directorStackView.setText(key: detail.key(of: .director),
                                                   value: detail.value(of: .director))
                    self.productYearStackView.setText(key: detail.key(of: .productYear),
                                                      value: detail.value(of: .productYear))
                    self.openYearStackView.setText(key: detail.key(of: .openYear),
                                                   value: detail.value(of: .openYear))
                    self.showTimeStackView.setText(key: detail.key(of: .showTime),
                                                   value: detail.value(of: .showTime))
                    self.watchGradeStackView.setText(key: detail.key(of: .watchGrade),
                                                     value: detail.value(of: .watchGrade))
                    self.nationStackView.setText(key: detail.key(of: .productNation),
                                                 value: detail.value(of: .productNation))
                    self.genreStackView.setText(key: detail.key(of: .genre),
                                                value: detail.value(of: .genre))
                    self.actorStackView.setText(key: detail.key(of: .actor),
                                                value: detail.value(of: .actor))
                }
            }
        }
    }
}
