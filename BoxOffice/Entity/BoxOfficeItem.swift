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
    
    private let identifier = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    init(title: String, showCountInformation: String, rank: String, rankDescription: NSAttributedString) {
        self.title = title
        self.showCountInformation = showCountInformation
        self.rank = rank
        self.rankDescription = rankDescription
    }
}
