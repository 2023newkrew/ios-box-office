//
//  BoxOfficeSearchResult.swift
//  BoxOffice
//
//  Created by john-lim on 2023/01/16.
//

import Foundation

struct DailyBoxOfficeSearchResult: Decodable {
    let type: String
    let searchRange: String
    let dailyList: [DailyBoxOffice]
    
    enum DailyBoxOfficeKeys: String, CodingKey {
        case result = "boxOfficeResult"
    }
    
    enum ResultKeys: String, CodingKey {
        case type = "boxofficeType"
        case searchRange = "showRange"
        case dailyList = "dailyBoxOfficeList"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: DailyBoxOfficeKeys.self)
        let results = try values.nestedContainer(keyedBy: ResultKeys.self, forKey: .result)
        
        type = try results.decode(String.self, forKey: .type)
        searchRange = try results.decode(String.self, forKey: .searchRange)
        dailyList = try results.decode([DailyBoxOffice].self, forKey: .dailyList)
    }
    
    struct DailyBoxOffice: Decodable {
        let audienceAccumulate: String
        let audienceCount: String
        let audienceCountChange: String
        let audienceCountChangeRate: String
        
        let movieCode: String
        let movieName: String
        let openDate: String
        
        let rank: String
        let rankChange: String
        let rankType: String
        let rowNumber: String
        
        let salesAccumulate: String
        let sales: String
        let salesChange: String
        let salesChangeRate: String
        let salesShare: String
        
        let screenCount: String
        let showCount: String

        enum CodingKeys: String, CodingKey {
            case audienceAccumulate = "audiAcc"
            case audienceCount = "audiCnt"
            case audienceCountChange = "audiInten"
            case audienceCountChangeRate = "audiChange"
            
            case movieCode = "movieCd"
            case movieName = "movieNm"
            case openDate = "openDt"
            
            case rank = "rank"
            case rankChange = "rankInten"
            case rankType = "rankOldAndNew"
            case rowNumber = "rnum"
            
            case salesAccumulate = "salesAcc"
            case sales = "salesAmt"
            case salesChange = "salesInten"
            case salesChangeRate = "salesChange"
            case salesShare = "salesShare"
            
            case screenCount = "scrnCnt"
            case showCount = "showCnt"
        }
    }
}


extension DailyBoxOfficeSearchResult.DailyBoxOffice {
    func summary() -> BoxOfficeSummary {
        return BoxOfficeSummary(movieCode: self.movieCode,
                                title: self.movieName,
                                rank: self.rank,
                                rankChange: self.rankChange,
                                rankType: self.rankType,
                                audienceCount: self.audienceCount,
                                audienceTotal: self.audienceAccumulate)
    }
}
