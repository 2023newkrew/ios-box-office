//
//  API.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import Foundation

enum API {
    case dailyBoxOffice
    case movie
    
    var baseURL: String {
        switch self {
        case .dailyBoxOffice:
            return "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
        case .movie:
            return "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?"
        }
    }
    
    func url(yyyyMMdd: String) -> String {
        return self.baseURL + "key=" + Storage.koficAPIKey + "&targetDt=" + yyyyMMdd
    }
}
