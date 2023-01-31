//
//  BoxOfficeListCell.swift
//  BoxOffice
//
//  Created by john-lim on 2023/01/25.
//

import UIKit

class BoxOfficeListCell: UICollectionViewListCell {
    
    private enum LabelFont {
        static let rank = UIFont.preferredFont(forTextStyle: .largeTitle)
        static let rankStatus = UIFont.preferredFont(forTextStyle: .body)
        static let title = UIFont.preferredFont(forTextStyle: .title2)
        static let audienceStatistics = UIFont.preferredFont(forTextStyle: .body)
    }
    
    private enum Constraint {
        static let verticalPadding = CGFloat(10)
        static let horizontalPadding = CGFloat(15)
        
        static let itemVertialMargin = CGFloat(5)
        static let itemHorizontalMargin = CGFloat(10)
        
        static let accessoryWidth = CGFloat(30)
        
        static let rankWidthRatio = CGFloat(0.2)
    }
    
    private let rankLabel: UILabel = UILabel(textAlignment: .center, font: LabelFont.rank)
    
    private let rankStatusLabel: UILabel = UILabel(textAlignment: .center, font: LabelFont.rankStatus)
    
    private let titleLabel: UILabel = UILabel(textAlignment: .left, font: LabelFont.title)
    
    private let audienceStatisticsLabel: UILabel = UILabel(textAlignment: .left, font: LabelFont.audienceStatistics)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setAttribute()
        self.setHierachy()
        self.setConstraint()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ data: BoxOfficeSummary) {
        let rank = data.rank
        let rankType = data.rankType
        let rankChange = Int(data.rankChange) ?? 0
        let title = data.title
        let audienceCount = data.audienceCount
        let audienceAccumulate = data.audienceTotal
        
        self.rankLabel.text = rank
        self.rankStatusLabel.attributedText = rankStatus(rankType: rankType,
                                                         rankChange: rankChange)
        self.titleLabel.text = title
        self.audienceStatisticsLabel.text = "오늘 \(audienceCount.decimalFormat()) / 총 \(audienceAccumulate.decimalFormat())"
    }
    
    private func setAttribute() {
        self.layer.borderColor = UIColor.systemGray4.cgColor
        self.layer.borderWidth = 0.5
        self.accessories = [.disclosureIndicator(options: .init(reservedLayoutWidth: .custom(Constraint.accessoryWidth), tintColor: .systemGray))]
        self.backgroundColor = .white
    }
    
    private func setHierachy() {
        self.addSubview(self.rankLabel)
        self.addSubview(self.rankStatusLabel)
        self.addSubview(self.titleLabel)
        self.addSubview(self.audienceStatisticsLabel)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            self.rankLabel.topAnchor
                .constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.topAnchor,
                            constant: Constraint.verticalPadding),
            self.rankLabel.leadingAnchor
                .constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                            constant: Constraint.horizontalPadding),
            self.rankLabel.widthAnchor
                .constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor,
                            multiplier: Constraint.rankWidthRatio),
            
            self.rankStatusLabel.topAnchor
                .constraint(equalTo: self.rankLabel.bottomAnchor,
                            constant: Constraint.itemVertialMargin),
            self.rankStatusLabel.centerXAnchor
                .constraint(equalTo: self.rankLabel.centerXAnchor),
            self.rankStatusLabel.bottomAnchor
                .constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor,
                            constant: -Constraint.verticalPadding),
            
            self.titleLabel.topAnchor
                .constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                            constant: Constraint.verticalPadding),
            self.titleLabel.leadingAnchor
                .constraint(equalTo: self.rankLabel.trailingAnchor,
                            constant: Constraint.itemHorizontalMargin),
            self.titleLabel.centerYAnchor
                .constraint(equalTo: self.rankLabel.centerYAnchor),
            self.titleLabel.trailingAnchor
                .constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.trailingAnchor,
                            constant: -Constraint.horizontalPadding - Constraint.accessoryWidth),
            
            self.audienceStatisticsLabel.topAnchor
                .constraint(equalTo: self.titleLabel.bottomAnchor,
                            constant: Constraint.itemVertialMargin),
            self.audienceStatisticsLabel.leadingAnchor
                .constraint(equalTo: self.titleLabel.leadingAnchor),
            self.audienceStatisticsLabel.bottomAnchor
                .constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                            constant: -Constraint.verticalPadding),
            self.audienceStatisticsLabel.trailingAnchor
                .constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.trailingAnchor,
                            constant: -Constraint.horizontalPadding - Constraint.accessoryWidth),
        ])
    }
    
    private func rankStatus(rankType: String, rankChange: Int) -> NSAttributedString {
        if rankType == "NEW" {
            return NSMutableAttributedString(string: "신작")
                .applyColor(.red)
        }
        if rankType == "OLD" && rankChange > 0 {
            return NSMutableAttributedString(string: "▲")
                .applyColor(.red)
            + NSMutableAttributedString(string: "\(rankChange)")
                .applyColor(.black)
        }
        if rankType == "OLD" && rankChange < 0 {
            return NSMutableAttributedString(string: "▼")
                .applyColor(.blue)
            + NSMutableAttributedString(string: "\(abs(rankChange))")
                .applyColor(.black)
        }
        if rankType == "OLD" && rankChange == 0 {
            return NSMutableAttributedString(string: "-")
                .applyColor(.black)
        }
        return NSMutableAttributedString(string: "Error")
            .applyColor(.green)
    }
}

private extension UILabel {
    convenience init(textAlignment: NSTextAlignment, font: UIFont){
        self.init()
        self.textAlignment = textAlignment
        self.font = font
        self.adjustsFontForContentSizeCategory = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 0
    }
}
