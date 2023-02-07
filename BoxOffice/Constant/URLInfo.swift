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
    case searchMoviePosterImage
    
    var scheme: String {
        switch self {
        case .searchDailyBoxOffice, .searchDetailMovieInfo:
            return "http"
        case .searchMoviePosterImage:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .searchDailyBoxOffice, .searchDetailMovieInfo:
            return "kobis.or.kr"
        case .searchMoviePosterImage:
            return "dapi.kakao.com"
        }
    }
    
    var path: String {
        switch self {
        case .searchDailyBoxOffice:
            return "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        case .searchDetailMovieInfo:
            return "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
        case .searchMoviePosterImage:
            return "/v2/search/image"
        }
    }
    
    var defaultQuery: [URLQueryItem] {
        switch self {
        case .searchDailyBoxOffice, .searchDetailMovieInfo:
            var queryItem: [URLQueryItem] = []
            guard let keyQuery = AppKeys.boxOfficeAPI else {
                return []
            }
            for query in keyQuery {
                let appKey = URLQueryItem(name: query.key, value: query.value)
                queryItem.append(appKey)
            }
            return queryItem
        case .searchMoviePosterImage:
            return []
        }
    }
}
