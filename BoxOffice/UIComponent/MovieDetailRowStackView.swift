//
//  MovieDetailRowStackView.swift
//  BoxOffice
//
//  Created by john-lim on 2023/02/01.
//

import UIKit

class MovieDetailRowStackView: UIStackView {
    private let categoryLabel = UILabel(textAlignment: .center,
                                   font: .preferredFont(forTextStyle: .body))
    
    private let contentsLabel = UILabel(textAlignment: .left,
                                     font: .preferredFont(forTextStyle: .body))
    
    init() {
        super.init(frame: .zero)
        self.setAttribute()
        self.setHierarchy()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCategoryLabelWidth(constraintAnchor: NSLayoutDimension, multiplier: CGFloat) {
        categoryLabel.widthAnchor.constraint(equalTo: constraintAnchor,
                                        multiplier: multiplier).isActive = true
    }
    
    func setText(key: String, value: String) {
        self.categoryLabel.text = key
        self.contentsLabel.text = value
    }
    
    private func setAttribute() {
        self.axis = .horizontal
        self.spacing = CGFloat(10)
        self.alignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.categoryLabel.font = .preferredFont(forTextStyle: .headline)
    }
    
    private func setHierarchy() {
        [self.categoryLabel, self.contentsLabel].forEach { element in
            self.addArrangedSubview(element)
        }
    }
    
}

private extension UILabel {
    convenience init(textAlignment: NSTextAlignment, font: UIFont) {
        self.init()
        self.textAlignment = textAlignment
        self.font = font
        self.adjustsFontForContentSizeCategory = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 0
    }
}
