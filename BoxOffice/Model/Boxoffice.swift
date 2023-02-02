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
    let rank: Int
    let rankInten: Int
    let isNew: Bool
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

extension BoxofficeRecode: Hashable { }
