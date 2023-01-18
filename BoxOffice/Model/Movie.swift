//
//  Movie.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/17.
//

import Foundation

struct Movie: Decodable {
    let number: String
    let rank: String
    let rankingChange: String
    let rankOldOrNew: String
    let representativeCode: String
    let name: String
    let openDate: String
    let salesForTheDay: String
    let salesShareForTheDay: String
    let salesChange: String
    let salesRatioChange: String
    let cumulativeSales: String
    let audienceCount: String
    let audienceChange: String
    let audienceRatioChange: String
    let cumulativeAudience: String
    let screenCountForTheDay: String
    let showCountForTheDay: String

    enum CodingKeys: String, CodingKey {
        case number = "rnum"
        case rank
        case rankingChange = "rankInten"
        case rankOldOrNew = "rankOldAndNew"
        case representativeCode = "movieCd"
        case name = "movieNm"
        case openDate = "openDt"
        case salesForTheDay = "salesAmt"
        case salesShareForTheDay = "salesShare"
        case salesChange = "salesInten"
        case salesRatioChange = "salesChange"
        case cumulativeSales = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceChange = "audiInten"
        case audienceRatioChange = "audiChange"
        case cumulativeAudience = "audiAcc"
        case screenCountForTheDay = "scrnCnt"
        case showCountForTheDay = "showCnt"
    }
}
