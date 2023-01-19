//
//  DailyBoxOfficeAPI.swift
//  BoxOffice
//
//  Created by john-lim on 2023/01/17.
//

import Foundation

struct DailyBoxOfficeAPI {
    private let urlString = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    private let apiProvider: APIDataTaskProvider
    
    init(session: URLSessionCallable = URLSession.shared,
         query: DailyBoxOfficeAPIQuery) {
        self.apiProvider = APIDataTaskProvider(session: session,
                                       baseURL: self.urlString,
                                       query: query)
    }
    
    func dataTask(completion: @escaping (Data) -> ()) -> URLSessionDataTask? {
        return apiProvider.dataTask(completion: completion)
    }
}

