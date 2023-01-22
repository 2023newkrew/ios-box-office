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
        
        var compo: URLComponents? = URLComponents(string: URLInfo.baseURL)
        compo?.path = URLInfo.searchDetailMovieInfo.path
        compo?.queryItems = [URLInfo.key!]
        compo?.queryItems?.append(URLQueryItem(name: QueryKeys.movieCode, value: "20124079"))
        guard let url = compo?.url else { return }
        MockURLProtocol.successMock[url.absoluteString] = jsonDetailData

        let expects = XCTestExpectation(description: "영화 정보 TEST Expecatation")
        urlSession.fetch(searchTarget: .searchDetailMovieInfo,
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
        
        var compo: URLComponents? = URLComponents(string: URLInfo.baseURL)
        compo?.path = URLInfo.searchDailyBoxOffice.path
        compo?.queryItems = [URLInfo.key!]
        compo?.queryItems?.append(URLQueryItem(name: QueryKeys.targetDate, value: Date.today))
        guard let url = compo?.url else { return }
        MockURLProtocol.successMock[url.absoluteString] = jsonDailyData
        
        let expects = XCTestExpectation(description: "오늘의 박스 오피스 TEST Expecatation")
        urlSession.fetch(searchTarget: .searchDailyBoxOffice,
                         queryItems: [QueryKeys.targetDate: Date.today]) {
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
        
        var compo: URLComponents? = URLComponents(string: URLInfo.baseURL)
        compo?.path = URLInfo.searchDailyBoxOffice.path
        compo?.queryItems = [URLInfo.key!]
        compo?.queryItems?.append(URLQueryItem(name: QueryKeys.targetDate, value: Date.today))
        guard let url = compo?.url else { return }
        MockURLProtocol.successMock[url.absoluteString] = jsonDailyData
        
        let expects = XCTestExpectation(description: "오늘의 박스 오피스 TEST Expecatation")
        urlSession.fetch(searchTarget: .searchDailyBoxOffice,
                         queryItems: [QueryKeys.targetDate: Date.today]) {
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
        
        var compo: URLComponents? = URLComponents(string: URLInfo.baseURL)
        compo?.path = URLInfo.searchDailyBoxOffice.path
        compo?.queryItems = [URLInfo.key!]
        compo?.queryItems?.append(URLQueryItem(name: QueryKeys.targetDate, value: Date.today))
        guard let url = compo?.url else { return }
        MockURLProtocol.successMock[url.absoluteString] = jsonDailyData
        
        let expects = XCTestExpectation(description: "오늘의 박스 오피스 TEST Expecatation")
        urlSession.fetch(searchTarget: .searchDailyBoxOffice,
                         queryItems: [QueryKeys.targetDate: Date.today]) {
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
