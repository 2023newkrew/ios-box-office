//
//  BoxOfficeAPI.swift
//  BoxOffice
//
//  Created by john-lim on 2023/01/20.
//

import Foundation
enum APIRequest {
    case getDailyBoxOffice(key: String,
                           targetDate: String,
                           itemPerPage: Int? = nil,
                           enableMultiMovie: String? = nil,
                           nationSelectCode: String? = nil,
                           areaCode: String? = nil)
    case getMovieDetail(key: String,
                        movieCode: String)
    
    var urlString: String {
        switch self {
        case .getDailyBoxOffice:
            return APIURL.dailyBoxOffice
        case .getMovieDetail:
            return APIURL.movieDetail
        }
    }
    
    var query: [URLQueryItem] {
        var items: [URLQueryItem] = []
        
        switch self {
        case let .getDailyBoxOffice(key, targetDate, itemPerPage, enableMultiMovie, nationSelectCode, areaCode):
            items.append(URLQueryItem(name: "key", value: key))
            items.append(URLQueryItem(name: "targetDt", value: targetDate))
            if let itemPerPage = itemPerPage {
                items.append(URLQueryItem(name: "itemPerPage", value: String(itemPerPage)))
            }
            items.append(URLQueryItem(name: "multiMovieYn", value: enableMultiMovie))
            items.append(URLQueryItem(name: "repNationCd", value: nationSelectCode))
            items.append(URLQueryItem(name: "wideAreaCd", value: areaCode))
        case let .getMovieDetail(key, movieCode):
            items.append(URLQueryItem(name: "key", value: key))
            items.append(URLQueryItem(name: "movieCd", value: movieCode))
        }
        
        return items
    }
    
    var method: HTTPMethod {
        switch self {
        case .getDailyBoxOffice:
            return .get
        case .getMovieDetail:
            return .get
        }
    }
}
