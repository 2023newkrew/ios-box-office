//
//  MovieInformationEndpoint.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import Foundation

struct MovieInformationEndpoint: MovieAPIEndpoint {
    typealias APIResponse = MovieInformationResponse
    
    let method: HTTPMethod = .get
    let body: Data? = nil
    let path: String = "/movie/searchMovieInfo.json"
    let headers: [String : String]? = nil
    let movieCode: String
    var queries: [String: String?] {
        [
            "key": self.serviceKey,
            "movieCd": self.movieCode
        ]
    }
}
