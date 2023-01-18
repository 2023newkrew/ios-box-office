//
//  DailyBoxOffice.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/17.
//

import Foundation

struct DailyBoxOffice: Decodable {
    struct Information: Decodable {
        let type: String
        let showRange: String
        let movieList: [Movie]

        enum CodingKeys: String, CodingKey {
            case type = "boxofficeType"
            case showRange
            case movieList = "dailyBoxOfficeList"
        }
    }
    
    let information: Information
    
    enum CodingKeys: String, CodingKey {
        case information = "boxOfficeResult"
    }
}
