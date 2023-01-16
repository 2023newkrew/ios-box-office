//
//  BoxOfficeSearchResult.swift
//  BoxOffice
//
//  Created by john-lim on 2023/01/16.
//

import Foundation

struct BoxOfficeSearchResult: Decodable {
    let result: BoxOfficeResult
    
    enum CodingKeys: String, CodingKey {
        case result = "boxOfficeResult"
    }
}

struct BoxOfficeResult: Decodable {
    let type: String
    let searchRange: String
    let dailyList: [DailyBoxOffice]
    
    enum CodingKeys: String, CodingKey {
        case type = "boxofficeType"
        case searchRange = "showRange"
        case dailyList = "dailyBoxOfficeList"
    }
}

struct DailyBoxOffice: Decodable {
    let audienceAccumulate: String
    let audienceIncrement: String
    let audienceIncrementChange: String
    let audienceIncrementChangeRate: String
    
    let movieCode: String
    let movieName: String
    let openDate: String
    
    let rank: String
    let rankChange: String
    let rankType: String
    let rowNumber: String
    
    let salesAccumulate: String
    let salesIncrement: String
    let salesIncrementChange: String
    let salesIncrementChangeRate: String
    let salesShare: String
    
    let screenCount: String
    let showCount: String

    enum CodingKeys: String, CodingKey {
        case audienceAccumulate = "audiAcc"
        case audienceIncrement = "audiCnt"
        case audienceIncrementChange = "audiInten"
        case audienceIncrementChangeRate = "audiChange"
        
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        
        case rank = "rank"
        case rankChange = "rankInten"
        case rankType = "rankOldAndNew"
        case rowNumber = "rnum"
        
        case salesAccumulate = "salesAcc"
        case salesIncrement = "salesAmt"
        case salesIncrementChange = "salesInten"
        case salesIncrementChangeRate = "salesChange"
        case salesShare = "salesShare"
        
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}
