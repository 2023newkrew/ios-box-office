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
    
    private var baseURL: String {
        return "https://www.kobis.or.kr/kobisopenapi/webservice/rest/"
    }
    
    private var url: String {
        switch self {
        case .dailyBoxOffice:
            return baseURL + "boxoffice/searchDailyBoxOfficeList.json?"
        case .movie:
            return baseURL + "movie/searchMovieInfo.json?"
        }
    }
    
    func finalURL(yyyyMMdd: String) -> String {
        return self.url + "key=" + Storage.koficAPIKey + "&targetDt=" + yyyyMMdd
    }
}
