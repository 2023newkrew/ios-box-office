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
    
    private let scrollView = UIScrollView()
    private let mainStackView = UIStackView()
    
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
    }
    
    init(movieCode: String, movieName: String) {
        self.movieCode = movieCode
        self.movieName = movieName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension DetailMovieInfoViewController {
    private func configureAttribute() {
        view.backgroundColor = .systemBackground
        
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
            directorNameStackView, produceYearStackView, openDateStackView,
            showTimeStackView, gradeStackView, nationStackView,
            genreStackView, actorStackView
        ].forEach { stackView in
            mainStackView.addArrangedSubview(stackView)
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
}
