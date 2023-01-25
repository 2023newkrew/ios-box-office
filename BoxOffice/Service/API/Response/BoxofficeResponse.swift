//
//  BoxofficeResponse.swift
//  Boxoffice
//
//  Created by kakao on 2023/01/16.
//

import Foundation

struct BoxofficeResponse: Decodable {
    let boxofficeResultResponse: BoxOfficeResultResponse
    
    enum CodingKeys: String, CodingKey {
        case boxofficeResultResponse = "boxOfficeResult"
    }
}

struct BoxOfficeResultResponse: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [MovieResponse]
}

struct MovieResponse: Decodable {
    let rankNumber: String
    let rank: String
    let rankInten: String
    let rankOldAndNew: String
    let movieCode: String
    let movieName: String
    let openDate: String
    let salesAmount: String
    let salesShare: String
    let salesInten: String
    let salesChange: String
    let salesAccumulation: String
    let audienceCount: String
    let audienceInten: String
    let audienceChange: String
    let audienceAccumulation: String
    let screenCount: String
    let showCount: String
    
    enum CodingKeys: String, CodingKey {
        case rankNumber = "rnum"
        case rank
        case rankInten
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case salesInten
        case salesChange
        case salesAccumulation = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceInten = "audiInten"
        case audienceChange = "audiChange"
        case audienceAccumulation = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}
