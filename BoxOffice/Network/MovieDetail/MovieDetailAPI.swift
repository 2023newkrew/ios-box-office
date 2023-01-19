//
//  MovieDetailAPI.swift
//  BoxOffice
//
//  Created by john-lim on 2023/01/17.
//

import Foundation

struct MovieDetailAPI {
    private let urlString = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
    private let apiProvider: APIDataTaskProvider
    
    init(session: URLSessionCallable = URLSession.shared,
         query: MovieDetailAPIQuery) {
        self.apiProvider = APIDataTaskProvider(session: session,
                                       baseURL: self.urlString,
                                       query: query)
    }
    
    func dataTask(completion: @escaping (Data) -> ()) -> URLSessionDataTask? {
        return self.apiProvider.dataTask(completion: completion)
    }
}
