//
//  MockURLSession.swift
//  BoxOfficeTests
//
//  Created by john-lim on 2023/01/19.
//

import Foundation

class MockURLSession: URLSessionCallable {
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask(completion: completionHandler)
    }
}
