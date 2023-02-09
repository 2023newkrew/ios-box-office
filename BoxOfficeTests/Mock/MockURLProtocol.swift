//
//  SessionCallable.swift
//  BoxOffice
//
//  Created by john-lim on 2023/02/06.
//

import Foundation
import XCTest

enum MockSessionError: Error {
    case notConfigured
    case notSupported
    case notFoundData
}

class MockURLProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        do {
            let (response, data) = try self.requestHandler(self.request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {
    }
    
    private func requestHandler(_: URLRequest) throws -> (HTTPURLResponse, Data) {
        guard let url = request.url,
              let method = request.httpMethod else {
            throw MockSessionError.notConfigured
        }
        
        var components = URLComponents(string:url.absoluteString)
        components?.query = nil
        
        switch (components?.url?.absoluteString, method)  {
        case (APIURL.dailyBoxOffice, HTTPMethod.get.rawValue):
            guard let data = NSDataAsset(name: "DailyBoxOfficeAPITestData",
                                         bundle: Bundle(for: APIDataTaskTests.self))?.data else {
                throw MockSessionError.notFoundData
            }
            return (HTTPURLResponse(), data)
        case (APIURL.movieDetail, HTTPMethod.get.rawValue):
            guard let data = NSDataAsset(name: "MovieDetailAPITestData",
                                         bundle: Bundle(for: APIDataTaskTests.self))?.data else {
                throw MockSessionError.notFoundData
            }
            return (HTTPURLResponse(), data)
        default:
            throw MockSessionError.notSupported
        }
    }
}

