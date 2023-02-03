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
    }
    
    private func configureHierarchy() {
        
    }
    
    private func configureLayout() {
        
    }
}
