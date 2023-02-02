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
        scrollView.backgroundColor = .systemGray
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let detailStackView: UIStackView = UIStackView(axis: .vertical)
    
    private let posterImageView: UIImageView = {
        let image = UIImage.init(systemName: "pencil")
        let imageView = UIImageView(image: image)
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
        // Do any additional setup after loading the view.
        
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
        self.view.addSubview(self.scrollView)
        
        self.scrollView.backgroundColor = .systemGray5
        self.scrollView.refreshControl = self.refresher
        self.scrollView.addSubview(self.detailStackView)
        
        detailStackView.addArrangedSubview(posterImageView)
        [self.directorStackView,
         self.productYearStackView,
         self.openYearStackView,
         self.showTimeStackView,
         self.watchGradeStackView,
         self.nationStackView,
         self.genreStackView,
         self.actorStackView
        ].forEach { stack in
            detailStackView.addArrangedSubview(stack)
            stack.setText(key: "상영시간", value: "asdfasdfsadfasd")
        }
        
        
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        self.detailStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        self.detailStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20).isActive = true
        self.detailStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        self.detailStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        
        
        
        detailStackView.subviews.forEach { sub in
            if let sub = sub as? MovieDetailRowStackView {
                sub.setKeyLabelWidth(constraintAnchor: self.scrollView.widthAnchor, multiplier: 0.2)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadData()
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

private extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
    }
}
