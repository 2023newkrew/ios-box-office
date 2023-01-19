//
//  MockURLSession.swift
//  BoxOfficeTests
//
//  Created by john-lim on 2023/01/19.
//

import Foundation

class MockURLSession: URLSessionCallable {
    private let mockResponse: (data: Data?, urlResponse: URLResponse?, error: Error?)
    
    init(data: Data?,
         urlResponse: URLResponse?,
         error: Error?) {
        self.mockResponse = (data, urlResponse, error)
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask {
            completionHandler(self.mockResponse.data,
                              self.mockResponse.urlResponse,
                              self.mockResponse.error)
        }
    }
}
