//
//  MockURLSessionDataTask.swift
//  BoxOfficeTests
//
//  Created by john-lim on 2023/01/19.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
    private let completion: (Data?, URLResponse?, Error?) -> Void
    
    init(completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.completion = completion
    }
    
    override func resume() {
        let data: Data? = nil
        let response: URLResponse? = nil
        let error: Error? = nil
        completion(data, response, error)
    }
}
