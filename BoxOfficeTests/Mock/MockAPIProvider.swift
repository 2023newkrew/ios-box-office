//
//  MockAPIProvider.swift
//  BoxOfficeTests
//
//  Created by john-lim on 2023/01/25.
//

import Foundation
import UIKit

class MockAPIProvider {
    let baseURL: String
    let query: [URLQueryItem]?
    let method: HTTPMethod
    
    init(request: APIRequest) {
        self.baseURL = request.urlString
        self.query = request.query
        self.method = request.method
    }
    
    private func urlRequest() -> URLRequest? {
        var urlComponents = URLComponents(string: self.baseURL)
        if let query = self.query {
            urlComponents?.queryItems = query
        }
        guard let url = urlComponents?.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        return request
    }
}

extension MockAPIProvider: URLSessionCallable {
    func startLoading(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let data = self.data()
        
        completionHandler(data, nil, nil)
    }
    
    private func data() -> Data? {
        switch (self.baseURL, self.method) {
        case (APIURL.dailyBoxOffice, HTTPMethod.get):
            return NSDataAsset(name: "DailyBoxOfficeAPITestData",
                               bundle: Bundle(for: APIDataTaskTests.self))?.data
        case (APIURL.movieDetail, HTTPMethod.get):
            return NSDataAsset(name: "MovieDetailAPITestData",
                               bundle: Bundle(for: APIDataTaskTests.self))?.data
        default:
            return nil
        }
    }
    
    func stopLoading() {
        return
    }
}
