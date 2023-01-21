//
//  MockURLSessionProtocol.swift
//  BoxOfficeTests
//
//  Created by kakao on 2023/01/21.
//

import Foundation

enum MockSessionError: Error {
    case notSupported
}

typealias RequestURL = String

class MockURLProtocol: URLProtocol {
    static var successMock: [RequestURL: Data] = [:]
    static var failureMock: [RequestURL: Error] = [:]
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let path = request.url?.absoluteString {
            if let mockData = MockURLProtocol.successMock[path] {
                client?.urlProtocol(self, didLoad: mockData)
                client?.urlProtocol(self, didReceive: HTTPURLResponse(), cacheStoragePolicy: .allowed)
            } else if let error = MockURLProtocol.failureMock[path] {
                client?.urlProtocol(self, didFailWithError: error)
            }
        } else {
            client?.urlProtocol(self, didFailWithError: MockSessionError.notSupported)
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
}
