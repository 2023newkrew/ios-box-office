//
//  MockingNetworkTests.swift
//  BoxOfficeTests
//
//  Created by kakao on 2023/01/19.
//

import XCTest

final class MockingNetworkTests: XCTestCase {
    var mockSession: MockURLSession!
    var mockNetworkProvider: MockNetworkProvider!
    var sut: MockMovieService!
    
    override func setUp() {
        self.mockSession = MockURLSession()
        self.mockNetworkProvider = MockNetworkProvider(session: mockSession)
        self.sut = MockMovieService(mockNetworkProvider: mockNetworkProvider)
    }

    func test_boxoffice_Request() throws {
        let dummyData = NSDataAsset(name: "box_office_sample")?.data
        self.mockSession.dummyData = dummyData
        
        self.sut.fetchBoxoffice(date: Date()) { result in
            switch result {
            case .success:
                XCTAssert(true)
            case .failure:
                XCTFail()
            }
        }
    }

    func test_movieDetail_Request() throws {
        let dummyData = NSDataAsset(name: "searchMovieInfo_sample")?.data
        self.mockSession.dummyData = dummyData
        
        self.sut.fetchMovieInformation(for: "20124079") { result in
            switch result {
            case .success:
                XCTAssert(true)
            case .failure:
                XCTFail()
            }
        }
    }
}
