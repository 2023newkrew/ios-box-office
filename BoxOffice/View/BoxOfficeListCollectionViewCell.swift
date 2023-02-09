//
//  BoxOfficeListCollectionViewCell.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/31.
//

import UIKit

class BoxOfficeListCollectionViewCell: UICollectionViewListCell {
    private let leftVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    private let rightVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    private let rankLabel: VerticalAlignLabel = {
        let label = VerticalAlignLabel()
        label.verticalAlignment = .bottom
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    private let rankDescriptionLabel: VerticalAlignLabel = {
        let label = VerticalAlignLabel()
        label.verticalAlignment = .top
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    private let movieNameLabel: VerticalAlignLabel = {
        let label = VerticalAlignLabel()
        label.verticalAlignment = .bottom
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    private let movieInfoLabel: VerticalAlignLabel = {
        let label = VerticalAlignLabel()
        label.verticalAlignment = .top
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = .systemGray3
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureHierarchy()
        self.configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureCell(with item: DailyMovie) {
        self.rankLabel.text = item.rank
        self.movieNameLabel.text = item.name
        
        self.configureRankDescriptionLabel(rankOldOrNew: item.rankOldOrNew, rankingChange: item.rankingChange)
        self.configureMovieInfoLabel(audienceCount: item.audienceCount, cumulativeAudience: item.cumulativeAudience)
    }
    
    private func configureHierarchy() {
        self.contentView.addSubview(self.leftVerticalStackView)
        self.contentView.addSubview(self.rightVerticalStackView)
        self.contentView.addSubview(self.chevronImageView)
        
        self.leftVerticalStackView.addArrangedSubview(self.rankLabel)
        self.leftVerticalStackView.addArrangedSubview(self.rankDescriptionLabel)
        self.rightVerticalStackView.addArrangedSubview(self.movieNameLabel)
        self.rightVerticalStackView.addArrangedSubview(self.movieInfoLabel)
    }
    
    private func configureConstraints() {
        self.leftVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        self.rightVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        self.chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.leftVerticalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.leftVerticalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.leftVerticalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.leftVerticalStackView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.25),
            
            self.rightVerticalStackView.leadingAnchor.constraint(equalTo: self.leftVerticalStackView.trailingAnchor),
            self.rightVerticalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.rightVerticalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.rightVerticalStackView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.65),
            
            self.chevronImageView.leadingAnchor.constraint(equalTo: self.rightVerticalStackView.trailingAnchor),
            self.chevronImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 40),
            self.chevronImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -40),
            self.chevronImageView.widthAnchor.constraint(equalTo: self.chevronImageView.heightAnchor, multiplier: 0.8)
        ])
    }
    
    private func configureRankDescriptionLabel(rankOldOrNew: String, rankingChange: String) {
        let isNew: Bool = (rankOldOrNew != "OLD")
        guard let rankingChange = Int(rankingChange) else {
            return
        }
        let isRankingRise: Bool = (rankingChange > 0)
        let rankingChangeValue: Int = abs(rankingChange)
        
        if isNew {
            self.rankDescriptionLabel.text = "신작"
            self.rankDescriptionLabel.textColor = .red
            return
        }
        if rankingChangeValue == 0 {
            self.rankDescriptionLabel.text = "-"
            return
        }
        if isRankingRise {
            let text = "▲" + String(rankingChangeValue)
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: (text as NSString).range(of: "▲"))
            self.rankDescriptionLabel.attributedText = attributedString
            return
        } else {
            let text = "▼" + String(rankingChangeValue)
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: (text as NSString).range(of: "▼"))
            self.rankDescriptionLabel.attributedText = attributedString
            return
        }
    }
    
    private func configureMovieInfoLabel(audienceCount: String, cumulativeAudience: String) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        guard let audienceCount = Int(audienceCount),
              let cumulativeAudience = Int(cumulativeAudience) else {
            return
        }
        guard let audienceCountString = numberFormatter.string(from: NSNumber(value: audienceCount)),
              let cumulativeAudienceString = numberFormatter.string(from: NSNumber(value: cumulativeAudience)) else {
            return
        }
        
        self.movieInfoLabel.text = "오늘 \(audienceCountString) / 총 \(cumulativeAudienceString)"
    }
}
