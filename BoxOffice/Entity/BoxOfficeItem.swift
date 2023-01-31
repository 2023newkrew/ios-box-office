//
//  BoxOfficeItem.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/30.
//

import UIKit

struct BoxOfficeItem: Hashable {
    let title: String
    let showCountInformation: String
    let rank: String
    let rankDescription: NSAttributedString
    
    private enum BoxOfficeContents {
        static let newContents = "신작"
        
        static func showCountInformation(_ todayShowCount: String,
                                         _ totalShowCount: String) -> String {
            return "오늘 \(todayShowCount) / 총 \(totalShowCount)"
        }
        static func isNew(_ rankType: String) -> Bool {
            return rankType == "NEW"
        }
    }
    
    init(title: String,
         showCountInformation: String,
         rank: String,
         rankDescription: NSAttributedString) {
        self.title = title
        self.showCountInformation = showCountInformation
        self.rank = rank
        self.rankDescription = rankDescription
    }
    
    init(_ dailyItem: DailyBoxOffice) {
        let todayShowCount = dailyItem.audienceCount.thousandSeparator
        let totalShowCount = dailyItem.audienceAccumulate.thousandSeparator
        let isNewItem = BoxOfficeContents.isNew(dailyItem.rankType)
        let description = (isNewItem ?
        BoxOfficeContents
            .newContents.colorNSAttributedString(.red) : dailyItem.rankChange.coloredDescription)
            .addLabelFont
        
        self.title = dailyItem.movieName
        self.showCountInformation = BoxOfficeContents
            .showCountInformation(todayShowCount, totalShowCount)
        self.rank = dailyItem.rank
        self.rankDescription = description
    }
}

private extension String {
    var thousandSeparator: String {
        guard let value = Int(self) else {
            return ""
        }
        
        let numberFormmater = NumberFormatter()
        numberFormmater.numberStyle = .decimal
        
        guard let thousandCommaResult = numberFormmater.string(from: NSNumber(value: value)) else {
            return ""
        }
        
        return thousandCommaResult
    }
    
    var coloredDescription: NSAttributedString {
        if self == "0" { return NSAttributedString(string: "-") }
        guard let value = Int(self) else { return NSAttributedString(string: "-") }
        if value < 0 {
            let mutableString = NSMutableAttributedString(string: "▼")
            mutableString.addAttribute(.foregroundColor,
                                       value: UIColor.blue,
                                       range: NSRange(location: 0, length: mutableString.length))
            mutableString.append(NSAttributedString(string: "\(-value)"))
            return NSAttributedString(attributedString: mutableString)
        } else {
            let mutableString = NSMutableAttributedString(string: "▲")
            mutableString.addAttribute(.foregroundColor,
                                       value: UIColor.red,
                                       range: NSRange(location: 0, length: mutableString.length))
            mutableString.append(NSAttributedString(string: description))
            return NSAttributedString(attributedString: mutableString)
        }
    }
    
    func colorNSAttributedString(_ color: UIColor) -> NSAttributedString {
        let mutableString = NSMutableAttributedString(string: self)
        let range = NSRange(location: 0, length: self.count)
        mutableString.addAttribute(.foregroundColor,
                                   value: color,
                                   range: range)
        return mutableString
    }
}

private extension NSAttributedString {
    var addLabelFont: NSAttributedString {
        let mutable = NSMutableAttributedString(attributedString: self)
        let length = mutable.length
        let range = NSRange(location: 0, length: length)
        
        mutable.addAttribute(.font,
                             value: UIFont.preferredFont(forTextStyle: .caption1),
                             range: range)
        return mutable
    }
}
