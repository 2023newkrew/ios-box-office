//
//  MockNetworkProvider.swift
//  BoxOfficeTests
//
//  Created by kakao on 2023/01/19.
//

import Foundation

final class MockNetworkProvider: NetworkProvider {
    var session: URLSessionable
    let decoder: DecodingUtility = JSONDecodingUtility()
    
    init(session: URLSessionable) {
        self.session = session
    }
}

final class MockURLSession: URLSessionable {
    var dummyData: Data!

    private let mockURLSessionDataTask: MockURLSessionDataTask = MockURLSessionDataTask()
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.mockURLSessionDataTask.resumeDidCall = {
            completionHandler(
                self.dummyData,
                HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "2", headerFields: nil),
                nil
            )
        }
        return self.mockURLSessionDataTask
    }
}

final class MockURLSessionDataTask: URLSessionDataTask {
    var resumeDidCall: () -> Void = { }
        
    override func resume() {
        resumeDidCall()
    }
}

final class MockMovieService: MovieService {
    var networkProvider: NetworkProvider
    
    init (mockNetworkProvider: MockNetworkProvider) {
        self.networkProvider = mockNetworkProvider
    }
}
