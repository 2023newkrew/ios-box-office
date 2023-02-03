//
//  DetailMovieInfoViewController.swift
//  BoxOffice
//
//  Created by kakao on 2023/02/03.
//

import UIKit

class DetailMovieInfoViewController: UIViewController {
    private let movieCode: String
    private let movieName: String

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
