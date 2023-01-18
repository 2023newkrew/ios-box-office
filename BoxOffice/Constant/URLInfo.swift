//
//  URLInfo.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import Foundation

enum URLInfo {
    case searchDailyBoxOffice
    case searchDetailMovieInfo
    var urlString: String {
        switch self {
        case .searchDailyBoxOffice:
            return "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
        case .searchDetailMovieInfo:
            return "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?"
        }
    }
}
