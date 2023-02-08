//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by kakao on 2023/02/06.
//

import UIKit

class MovieDetailViewController: UIViewController {
    private let movieService: MovieService
    private let imageService: ImageService
    private let movieCode: String
    private let movieTitle: String
    
    private var loadingIndicator: UIActivityIndicatorView!
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        return stackView
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let directorStackView = MovieDetailFactorStackView(titleText: "감독")
    private let productYearStackView =  MovieDetailFactorStackView(titleText: "제작년도")
    private let openDateStackView =  MovieDetailFactorStackView(titleText: "개봉일")
    private let runningTimeStackView = MovieDetailFactorStackView(titleText: "상영시간")
    private let auditGradeStackView =  MovieDetailFactorStackView(titleText: "관람등급")
    private let nationStackView =  MovieDetailFactorStackView(titleText: "국가")
    private let genreStackView = MovieDetailFactorStackView(titleText: "장르")
    private let actorStackView = MovieDetailFactorStackView(titleText: "배우")
    
    init(
        movieService: MovieService,
        imageService: ImageService,
        movieCode: String,
        movieTitle: String
    ) {
        self.movieService = movieService
        self.imageService = imageService
        self.movieCode = movieCode
        self.movieTitle = movieTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = self.movieTitle
        self.configureHierarchy()
        self.configureConstraint()
        self.configureLoadingIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchMovieDetail()
        self.fetchMoviePosterImage()
    }
    
    private func fetchMovieDetail() {
        self.movieService.fetchMovieInformation(for: self.movieCode) { result in
            switch result {
            case .success(let movie):
                DispatchQueue.main.async {
                    self.configureContent(for: movie)
                }
            case .failure:
                DispatchQueue.main.async {
                    self.presentErrorAlert(for: "영화 정보를 불러올 수 없습니다.")
                }
            }
        }
    }
    
    private func fetchMoviePosterImage() {
        self.loadingIndicator.isHidden = false
        self.loadingIndicator.startAnimating()
        self.imageService.fetchPosterImage(for: self.movieTitle) { result in
            self.loadingIndicator.isHidden = true
            self.loadingIndicator.stopAnimating()
            switch result {
            case .success(let posterImage):
                DispatchQueue.main.async {
                    self.posterImageView.heightAnchor.constraint(
                        equalTo: self.posterImageView.widthAnchor,
                        multiplier: posterImage.aspectRatio
                    ).isActive = true
                }
                guard let url = URL(string: posterImage.imageURL) else { return }
                ImageLoadUtility.fetchImage(imageURL: url) { data in
                    DispatchQueue.main.async {
                        self.posterImageView.image = UIImage(data: data)
                    }
                }
            case .failure:
                DispatchQueue.main.async {
                    self.presentErrorAlert(for: "포스터 이미지를 불러올 수 없습니다.")
                }
            }
        }
    }
    
    private func configureContent(for movie: Movie) {
        self.directorStackView.setContentLabel(
            movie.directors.map { $0.peopleName }.joined(separator: " ")
        )
        self.productYearStackView.setContentLabel(movie.productionYear)
        if let openDate = movie.openDate {
            self.openDateStackView.setContentLabel(DateFormatter.yearMonthDayWithDash.string(from: openDate))
        } else {
            self.openDateStackView.setContentLabel("-")
        }

        self.runningTimeStackView.setContentLabel(movie.showTime)
        self.auditGradeStackView.setContentLabel(movie.audits[0].watchGradeName)
        self.nationStackView.setContentLabel(movie.nations.map { $0.nationName }.joined(separator: ", "))
        self.genreStackView.setContentLabel(movie.genres.map { $0.genreName }.joined(separator: ", "))
        self.actorStackView.setContentLabel(movie.actors.map { $0.peopleName }.joined(separator: ", "))
    }
    
    private func configureHierarchy() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.mainStackView)
        self.mainStackView.addArrangedSubview(self.posterImageView)
        self.mainStackView.addArrangedSubview(self.directorStackView)
        self.mainStackView.addArrangedSubview(self.productYearStackView)
        self.mainStackView.addArrangedSubview(self.openDateStackView)
        self.mainStackView.addArrangedSubview(self.runningTimeStackView)
        self.mainStackView.addArrangedSubview(self.auditGradeStackView)
        self.mainStackView.addArrangedSubview(self.nationStackView)
        self.mainStackView.addArrangedSubview(self.genreStackView)
        self.mainStackView.addArrangedSubview(self.actorStackView)
        self.mainStackView.setCustomSpacing(10, after: self.posterImageView)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.mainStackView.topAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.topAnchor),
            self.mainStackView.bottomAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.bottomAnchor),
            self.mainStackView.leadingAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.leadingAnchor),
            self.mainStackView.trailingAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.trailingAnchor),
            self.posterImageView.widthAnchor.constraint(equalToConstant: 480)
        ])
    }

    private func configureLoadingIndicator() {
        let loadingIndicator = UIActivityIndicatorView(frame: self.posterImageView.frame)
        self.loadingIndicator = loadingIndicator
    }
    
    private func presentErrorAlert(for title: String) {
        let alertController = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "확인", style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}
