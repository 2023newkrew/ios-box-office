//
//  BoxOfficeListCell.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/30.
//

import UIKit

class BoxOfficeListCell: UICollectionViewCell {
    static let reuseIdentifier = "box-office-list-cell-reuseidentifier"
    
    let accessoryImageView = UIImageView()
    
    let separatorView = UIView()
    
    let stackView:  UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        
        return stackView
    }()
    
    let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.alignment = .center
        
        return stackView
    }()
    
    let movieInfoView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    let titleLabel = UILabel()
    let showCountLabel = UILabel()
    
    let rankInfoView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    let rankLabel = UILabel()
    let rankDescriptionLabel = UILabel()
    
    var showsSeparator = true {
        didSet {
            updateSeparator()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BoxOfficeListCell {
    func configure() {
        rankLabel.textAlignment = .center
        rankDescriptionLabel.textAlignment = .center
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        showCountLabel.translatesAutoresizingMaskIntoConstraints = false
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        rankDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.adjustsFontForContentSizeCategory = true
        showCountLabel.adjustsFontForContentSizeCategory = true
        rankLabel.adjustsFontForContentSizeCategory = true
        rankDescriptionLabel.adjustsFontForContentSizeCategory = true
        
        titleLabel.numberOfLines = 0
        showCountLabel.numberOfLines = 0
        
        rankLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        showCountLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        separatorView.backgroundColor = .placeholderText
                
        let rtl = effectiveUserInterfaceLayoutDirection == .rightToLeft
        let chevronImageName = rtl ? "chevron.left" : "chevron.right"
        let chevronImage = UIImage(systemName: chevronImageName)
        
        accessoryImageView.image = chevronImage
        accessoryImageView.tintColor = UIColor.lightGray.withAlphaComponent(0.7)
        
        [titleLabel, showCountLabel].forEach { subView in
            movieInfoView.addArrangedSubview(subView)
        }
        
        [rankLabel, rankDescriptionLabel].forEach { subView in
            rankInfoView.addArrangedSubview(subView)
        }
        
        [rankInfoView, movieInfoView, accessoryImageView].forEach { subStackView in
            labelStackView.addArrangedSubview(subStackView)
        }
        
        [labelStackView, separatorView]
            .forEach { subview in
                stackView.addArrangedSubview(subview)
            }
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5),
            labelStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            rankInfoView.widthAnchor.constraint(equalTo: labelStackView.widthAnchor, multiplier: 0.2),
            accessoryImageView.widthAnchor.constraint(equalToConstant: 13),
            accessoryImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func updateSeparator() {
        separatorView.isHidden = !showsSeparator
    }
}
