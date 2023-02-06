//
//  DetailMovieInfoViewController.swift
//  BoxOffice
//
//  Created by kakao on 2023/02/03.
//

import UIKit

class DetailMovieInfoViewController: UIViewController {
    private enum SubjectInfo {
        static let director = "감독"
        static let produceYear = "제작년도"
        static let openDate = "개봉일"
        static let showTime = "상영시간"
        static let grade = "관람등급"
        static let nation = "제작국가"
        static let genre = "장르"
        static let actors = "배우"
    }
    private let movieCode: String
    private let movieName: String
    
    private let networkService: NetworkServiceProtocol
    
    private let scrollView = UIScrollView()
    private let mainStackView = UIStackView()
    
    private let activityView = UIActivityIndicatorView(style: .large)
    private let posterImageView = UIImageView()
    
    private let directorNameStackView = UIStackView()
    private let directorNameLabel = UILabel()
    private let directorNameContentLabel = UILabel()
    
    private let produceYearStackView = UIStackView()
    private let produceYearLabel = UILabel()
    private let produceYearContentLabel = UILabel()
    
    private let openDateStackView = UIStackView()
    private let openDateLabel = UILabel()
    private let openDateContentLabel = UILabel()
    
    private let showTimeStackView = UIStackView()
    private let showTimeLabel = UILabel()
    private let showTimeContentLabel = UILabel()

    private let gradeStackView = UIStackView()
    private let gradeLabel = UILabel()
    private let gradeContentLabel = UILabel()
    
    private let nationStackView = UIStackView()
    private let nationLabel = UILabel()
    private let nationContentLabel = UILabel()
    
    private let genreStackView = UIStackView()
    private let genreLabel = UILabel()
    private let genreContentLabel = UILabel()
    
    private let actorStackView = UIStackView()
    private let actorLabel = UILabel()
    private let actorContentLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAttribute()
        configureHierarchy()
        configureLayout()
        loadDetailInfo()
        loadMoviePoster()
    }
    
    init(movieCode: String,
         movieName: String,
         networkService: NetworkServiceProtocol) {
        self.movieCode = movieCode
        self.movieName = movieName
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension DetailMovieInfoViewController {
    private func configureAttribute() {
        title = movieName
        view.backgroundColor = .systemBackground
        
        posterImageView.contentMode = .scaleAspectFit
        
        activityView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        
        [
            directorNameStackView, produceYearStackView, openDateStackView,
            showTimeStackView, gradeStackView, nationStackView,
            genreStackView, actorStackView
        ].forEach { stackView in
            stackView.axis = .horizontal
            stackView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [
            directorNameLabel, produceYearLabel, openDateLabel,
            showTimeLabel, gradeLabel, nationLabel,
            genreLabel, actorLabel
        ].forEach { label in
            label.adjustsFontForContentSizeCategory = true
            label.font = .systemFont(ofSize: label.font.pointSize, weight: .bold)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
        }
        
        directorNameLabel.text = SubjectInfo.director
        produceYearLabel.text = SubjectInfo.produceYear
        openDateLabel.text = SubjectInfo.openDate
        showTimeLabel.text = SubjectInfo.showTime
        gradeLabel.text = SubjectInfo.grade
        nationLabel.text = SubjectInfo.nation
        genreLabel.text = SubjectInfo.genre
        actorLabel.text = SubjectInfo.actors
        
        [
            directorNameContentLabel, produceYearContentLabel, openDateContentLabel,
            showTimeContentLabel, gradeContentLabel, nationContentLabel,
            genreContentLabel, actorContentLabel
        ].forEach { label in
            label.adjustsFontForContentSizeCategory = true
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureHierarchy() {
        [directorNameLabel, directorNameContentLabel].forEach { label in
            directorNameStackView.addArrangedSubview(label)
        }
        
        [produceYearLabel, produceYearContentLabel].forEach { label in
            produceYearStackView.addArrangedSubview(label)
        }
        
        [openDateLabel, openDateContentLabel].forEach { label in
            openDateStackView.addArrangedSubview(label)
        }
        
        [showTimeLabel, showTimeContentLabel].forEach { label in
            showTimeStackView.addArrangedSubview(label)
        }
        
        [gradeLabel, gradeContentLabel].forEach { label in
            gradeStackView.addArrangedSubview(label)
        }
        
        [nationLabel, nationContentLabel].forEach { label in
            nationStackView.addArrangedSubview(label)
        }
        
        [genreLabel, genreContentLabel].forEach { label in
            genreStackView.addArrangedSubview(label)
        }
        
        [actorLabel, actorContentLabel].forEach { label in
            actorStackView.addArrangedSubview(label)
        }
        
        [
            activityView, posterImageView, directorNameStackView, produceYearStackView,
            openDateStackView, showTimeStackView, gradeStackView,
            nationStackView, genreStackView, actorStackView
        ].forEach { subView in
            mainStackView.addArrangedSubview(subView)
        }
        
        scrollView.addSubview(mainStackView)
        view.addSubview(scrollView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            directorNameLabel
                .widthAnchor.constraint(equalTo: directorNameStackView.widthAnchor, multiplier: 0.2),
            produceYearLabel
                .widthAnchor.constraint(equalTo: produceYearStackView.widthAnchor, multiplier: 0.2),
            openDateLabel
                .widthAnchor.constraint(equalTo: openDateStackView.widthAnchor, multiplier: 0.2),
            showTimeLabel
                .widthAnchor.constraint(equalTo: showTimeStackView.widthAnchor, multiplier: 0.2),
            gradeLabel
                .widthAnchor.constraint(equalTo: gradeStackView.widthAnchor, multiplier: 0.2),
            nationLabel
                .widthAnchor.constraint(equalTo: nationStackView.widthAnchor, multiplier: 0.2),
            genreLabel
                .widthAnchor.constraint(equalTo: genreStackView.widthAnchor, multiplier: 0.2),
            actorLabel
                .widthAnchor.constraint(equalTo: actorStackView.widthAnchor, multiplier: 0.2),
            mainStackView
                .leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainStackView
                .trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainStackView
                .bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainStackView
                .topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStackView
                .widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            scrollView
                .leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView
                .trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView
                .bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView
                .topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    private func updateLabel(_ target: MovieInfo) {
        directorNameContentLabel.text = target.directors.map { $0.name }.reduce(nil) {
            (prev, next) in
            guard let prev = prev else { return "\(next)" }
            return "\(prev), \(next)"
        }
        produceYearContentLabel.text = target.produceYear
        openDateContentLabel.text = target.openDate
        showTimeContentLabel.text = target.showTime
        gradeContentLabel.text = target.audits.map { $0.watchGradeName }.reduce(nil) {
            (prev, next) in
            guard let prev = prev else { return "\(next)" }
            return "\(prev), \(next)"
        }
        nationContentLabel.text = target.nations.map { $0.name }.reduce(nil) {
            (prev, next) in
            guard let prev = prev else { return "\(next)" }
            return "\(prev), \(next)"
        }
        genreContentLabel.text = target.genres.map { $0.name }.reduce(nil) {
            (prev, next) in
            guard let prev = prev else { return "\(next)" }
            return "\(prev), \(next)"
        }
        actorContentLabel.text = target.actors.map { $0.name }.reduce(nil) {
            (prev, next) in
            guard let prev = prev else { return "\(next)" }
            return "\(prev), \(next)"
        }
    }
    
    private func loadDetailInfo() {
        networkService.fetch(searchTarget: .searchDetailMovieInfo,
                             headers: nil,
                             queryItems: [QueryKeys.movieCode: movieCode]) {
            [weak self] (networkResponse: Result<MovieInfoDetailResult,
                         NetworkServiceError>) -> Void in
            switch networkResponse {
            case .success(let success):
                let info = success.movieInfoResult.movieInfo
                DispatchQueue.main.async {
                    self?.updateLabel(info)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func updateImage(_ imageInfo: ImageInfo?) {
        guard let imageInfo = imageInfo, let url = URL(string: imageInfo.imageUrl) else {
            return
        }
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                DispatchQueue.main.async { [weak self] in
                    self?.posterImageView.image = image
                }
            }
        }
    }
    
    private func stopAnimateLoadingImage() {
        DispatchQueue.main.async { [weak self] in
            self?.activityView.stopAnimating()
        }
    }
    
    private func loadMoviePoster() {
        activityView.startAnimating()
        networkService.fetch(searchTarget: .searchMoviePosterImage,
                             headers: AppKeys.kakaoAPI,
                             queryItems: [QueryKeys.imageKeyQuery: QueryKeys.imageQuery(movieName)]) {
            [weak self] (networkResponse: Result<ImageSearchResult,
                         NetworkServiceError>) -> Void in
            switch networkResponse {
            case .success(let success):
                self?.updateImage(success.imageInfos.first)
                self?.stopAnimateLoadingImage()
            case .failure(let failure):
                print(failure.localizedDescription)
                self?.stopAnimateLoadingImage()
            }
        }
    }
}
