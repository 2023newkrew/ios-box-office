//
//  URLInfo.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import Foundation

enum URLInfo {
    static let baseURL = "http://www.kobis.or.kr/"
    static let key: URLQueryItem? = {
        guard let filePath = Bundle.main.url(forResource: "Info", withExtension: "plist") else {
            return nil
        }
        guard let plist = NSDictionary(contentsOf: filePath) else {
            return nil
        }
        guard let key = plist.object(forKey: "APP_KEY") as? String else {
            return nil
        }
        return URLQueryItem(name: "key", value: key)
    }()
    
    case searchDailyBoxOffice
    case searchDetailMovieInfo
    
    var path: String {
        switch self {
        case .searchDailyBoxOffice:
            return "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        case .searchDetailMovieInfo:
            return "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
        }
    }
}
