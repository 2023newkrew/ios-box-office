//
//  NetworkMockTests.swift
//  BoxOfficeTests
//
//  Created by kakao on 2023/01/17.
//

import XCTest

final class NetworkMockTests: XCTestCase {
    var urlSession: NetworkServiceProtocol!
    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        
        let mockURLSession = URLSession(configuration: config)
        
        urlSession = NetworkService(session: mockURLSession)
    }
    
    func test_영화_내용_잘_받아_오는_지() {
        guard let urlSession = urlSession else {
            XCTFail()
            return
        }
        
        let url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=1a82fdb5f1e1ef5882cd8325ecb30e91&movieCd=20124079"
        MockURLProtocol.successMock[url] = jsonDetailData

        let expects = XCTestExpectation(description: "영화 정보 TEST Expecatation")
        urlSession.fetch(searchTarget: .searchDetailMovieInfo,
                         headers: nil,
                         queryItems: [QueryKeys.movieCode: "20124079"]) {
            (networkResult: Result<MovieInfoDetailResult, NetworkServiceError>) -> Void in
            switch networkResult {
            case .success(let success):
                XCTAssertEqual("20124079", success.movieInfoResult.movieInfo.movieCode)
                expects.fulfill()
            case .failure(let failure):
                XCTFail(failure.localizedDescription)
                expects.fulfill()
            }
        }
        wait(for: [expects], timeout: 5.0)
    }
    
    func test_20220121_BoxOffice_잘_받아오는_지_타입() {
        guard let urlSession = urlSession else {
            XCTFail()
            return
        }
        
        let url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=1a82fdb5f1e1ef5882cd8325ecb30e91&targetDt=20230125"
        MockURLProtocol.successMock[url] = jsonDailyData
        
        let expects = XCTestExpectation(description: "오늘의 박스 오피스 TEST Expecatation")
        urlSession.fetch(searchTarget: .searchDailyBoxOffice,
                         headers: nil,
                         queryItems: [QueryKeys.targetDate: Date.dayString(.today, format: .yyyyMMdd)]) {
            (networkResult: Result<BoxOfficeSearchResult, NetworkServiceError>) -> Void in
            switch networkResult {
            case .success(let success):
                XCTAssertEqual(success.result.type, "일별 박스오피스")
                expects.fulfill()
            case .failure(let failure):
                XCTFail(failure.localizedDescription)
                expects.fulfill()
            }
        }
        wait(for: [expects], timeout: 5.0)
    }
    
    func test_20220121_BoxOffice_잘_받아오는_지_날짜() {
        guard let urlSession = urlSession else {
            XCTFail()
            return
        }
        
        let url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=1a82fdb5f1e1ef5882cd8325ecb30e91&targetDt=20230125"
        MockURLProtocol.successMock[url] = jsonDailyData
        
        let expects = XCTestExpectation(description: "오늘의 박스 오피스 TEST Expecatation")
        urlSession.fetch(searchTarget: .searchDailyBoxOffice,
                         headers: nil,
                         queryItems: [QueryKeys.targetDate: Date.dayString(.today, format: .yyyyMMdd)]) {
            (networkResult: Result<BoxOfficeSearchResult, NetworkServiceError>) -> Void in
            switch networkResult {
            case .success(let success):
                XCTAssertEqual(success.result.searchRange, "20220121~20220121")
                expects.fulfill()
            case .failure(let failure):
                XCTFail(failure.localizedDescription)
                expects.fulfill()
            }
        }
        wait(for: [expects], timeout: 5.0)
    }
    
    func test_20220121_BoxOffice_잘_받아오는_지_리스트() {
        guard let urlSession = urlSession else {
            XCTFail()
            return
        }
        
        let url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=1a82fdb5f1e1ef5882cd8325ecb30e91&targetDt=20230125"
        MockURLProtocol.successMock[url] = jsonDailyData
        
        let expects = XCTestExpectation(description: "오늘의 박스 오피스 TEST Expecatation")
        urlSession.fetch(searchTarget: .searchDailyBoxOffice,
                         headers: nil,
                         queryItems: [QueryKeys.targetDate: Date.dayString(.today, format: .yyyyMMdd)]) {
            (networkResult: Result<BoxOfficeSearchResult, NetworkServiceError>) -> Void in
            switch networkResult {
            case .success(let success):
                XCTAssertNotEqual(success.result.dailyList.count, 0)
                expects.fulfill()
            case .failure(let failure):
                XCTFail(failure.localizedDescription)
                expects.fulfill()
            }
        }
        wait(for: [expects], timeout: 5.0)
    }
}
