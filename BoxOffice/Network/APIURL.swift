//
//  APIURL.swift
//  BoxOffice
//
//  Created by john-lim on 2023/01/25.
//

import Foundation

enum APIURL {
    private static let boxOfficeBaseURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest"
    
    static let dailyBoxOffice = "\(boxOfficeBaseURL)/boxoffice/searchDailyBoxOfficeList.json"
    static let movieDetail = "\(boxOfficeBaseURL)/movie/searchMovieInfo.json"
    
}
