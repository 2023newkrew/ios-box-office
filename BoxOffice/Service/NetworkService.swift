//
//  NetworkService.swift
//  BoxOffice
//
//  Created by john-lim on 2023/02/07.
//

import Foundation

struct NetworkService {
    
    static func boxOfficeSummaryList(atPlainDate targetDate: String) async -> [BoxOfficeSummary]? {
        guard let key = SecretKey.boxOfficeAPIKey else {
            return nil
        }
        let request = APIRequest
            .getDailyBoxOffice(key: key, targetDate: targetDate)
        let apiProvider = APIProvider(request: request)
        let result = await apiProvider.startAsyncLoading()
        
        if let failure = result.failure() {
            NetworkService.logFailure(failure)
            return nil
        }
        
        guard let data = result.success()?.data else {
            return nil
        }
        
        return try? JSONDecoder().decode(DailyBoxOfficeSearchResult.self, from: data)
            .dailyList.map { boxOffice in
             boxOffice.summary()
         }
    }
    
    static func movieDetailSummary(of movieCode: String) async -> MovieDetailSummary? {
        guard let key = SecretKey.boxOfficeAPIKey else {
            return nil
        }
        let request = APIRequest.getMovieDetail(key: key, movieCode: movieCode)
        let apiProvider = APIProvider(request: request)
        let result = await apiProvider.startAsyncLoading()
        
        if let failure = result.failure() {
            NetworkService.logFailure(failure)
            return nil
        }
        
        guard let data = result.success()?.data else {
            return nil
        }
        
        return try? JSONDecoder().decode(MovieDetailResult.self, from: data).summary()
    }
    
    static func searchImageURL(of query: String) async -> URL? {
        guard let key = SecretKey.daumKaKaoAPIKey else {
            return nil
        }
        let request = APIRequest.getDaumImageSearch(key: key, searchQuery: query)
        let apiProvider = APIProvider(request: request)
        let result = await apiProvider.startAsyncLoading()
        
        if let failure = result.failure() {
            NetworkService.logFailure(failure)
            return nil
        }
        
        guard let data = result.success()?.data,
              let result = try? JSONDecoder().decode(ImageSearchResult.self, from: data),
              let imageURLString = result.documents.first?.imageURL else {
                  return nil
        }
        
        return URL(string: imageURLString)
    }
    
    static func loadData(from url: URL) async -> Data? {
        async let data: Data? = Task.detached {
            if let data = NetworkCache.image.cachedResponse(for: URLRequest(url: url))?.data {
                return data
            }
            return try? Data(contentsOf: url)
        }.value
        
        guard let data = await data else {
            return nil
        }
        
        if let response = HTTPURLResponse(url: url, statusCode: 200,
                                          httpVersion: nil, headerFields: nil) {
            let cachedResponse = CachedURLResponse(response: response, data: data)
            NetworkCache.image.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
        }
        
        return data
    }
    
    static private func logFailure(_ error: APIProvider.APIError) {
        print(error)
    }
}
