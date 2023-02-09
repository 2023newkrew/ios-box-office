//
//  LoadingView.swift
//  BoxOffice
//
//  Created by kakao on 2023/02/02.
//

import UIKit

class LoadingView: UIView {
    private let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureView()
        self.configureHierachy()
        self.configureActivityIndicator()
        self.configureActivityIndicatorView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureView() {
        self.backgroundColor = .white
    }
    
    private func configureHierachy() {
        self.addSubview(self.activityIndicatorView)
    }
    
    private func configureActivityIndicator() {
        self.activityIndicatorView.startAnimating()
    }
    
    private func configureActivityIndicatorView() {
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
