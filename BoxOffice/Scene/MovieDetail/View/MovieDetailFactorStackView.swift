//
//  MovieDetailFactorStackView.swift
//  BoxOffice
//
//  Created by kakao on 2023/02/07.
//

import UIKit

class MovieDetailFactorStackView: UIStackView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    init(titleText: String) {
        self.titleLabel.text = titleText
        super.init(frame: .zero)
        self.configureStackView()
        self.configureHierarchy()
        self.configureConstraint()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContentLabel(_ text: String) {
        self.contentLabel.text = text
    }
    
    private func configureStackView() {
        self.distribution = .fill
        self.alignment = .center
        self.axis = .horizontal
        self.spacing = 4
    }
    
    private func configureHierarchy() {
        self.addArrangedSubview(self.titleLabel)
        self.addArrangedSubview(self.contentLabel)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            self.titleLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
