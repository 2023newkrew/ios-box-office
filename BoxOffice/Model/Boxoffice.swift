//
//  Boxoffice.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/31.
//

import Foundation

struct Boxoffice {
    let date: Date
    let boxofficeRecodes: [BoxofficeRecode]
}

struct BoxofficeRecode {
    enum RankType: Hashable {
        case new
        case old(rankInten: Int)
    }
    
    let rank: Int
    let rankType: RankType
    let movieCode: String
    let movieName: String
    let openDate: Date
    let audienceCount: Int
    let audienceInten: Int
    let audienceChange: Double
    let audienceAccumulation: Int
    let screenCount: String
    let showCount: String
}

extension BoxofficeRecode: Hashable {
    static func == (lhs: BoxofficeRecode, rhs: BoxofficeRecode) -> Bool {
        lhs.movieCode == rhs.movieCode
    }
}
