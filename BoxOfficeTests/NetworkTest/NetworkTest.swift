//
//  NetworkTest.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/21.
//

import XCTest

final class NetworkTest: XCTestCase {
    var sut: URLSessionNetworkServiceProtocol!
    
    override func setUp() {
        sut = URLSessionNetworkService()
    }
    
    func test_영화_내용_잘_받아_오는_지() {
        let expects = XCTestExpectation(description: "영화 정보 TEST Expecatation")
        
        sut.fetch(searchTarget: .searchDetailMovieInfo,
                         queryItems: [QueryKeys.movieCode: "20124079"]) {
            (networkResult: Result<MovieInfoDetailResult, URLSessionNetworkServiceError>) -> Void in
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
    
    func test_오늘_BoxOffice_잘_받아오는_지_타입() {
        let expects = XCTestExpectation(description: "오늘의 박스 오피스 TEST Expecatation")
        
        sut.fetch(searchTarget: .searchDailyBoxOffice,
                         queryItems: [QueryKeys.targetDate: Date.today]) {
            (networkResult: Result<BoxOfficeSearchResult, URLSessionNetworkServiceError>) -> Void in
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
    
    func test_오늘_BoxOffice_잘_받아오는_지_날짜() {
        let expects = XCTestExpectation(description: "오늘의 박스 오피스 TEST Expecatation")
        
        sut.fetch(searchTarget: .searchDailyBoxOffice,
                         queryItems: [QueryKeys.targetDate: Date.today]) {
            (networkResult: Result<BoxOfficeSearchResult, URLSessionNetworkServiceError>) -> Void in
            switch networkResult {
            case .success(let success):
                XCTAssertEqual(success.result.searchRange, "\(Date.today)~\(Date.today)")
                expects.fulfill()
            case .failure(let failure):
                XCTFail(failure.localizedDescription)
                expects.fulfill()
            }
        }
        wait(for: [expects], timeout: 5.0)
    }
    
    func test_오늘_BoxOffice_잘_받아오는_지_리스트() {
        let expects = XCTestExpectation(description: "오늘의 박스 오피스 TEST Expecatation")
        
        sut.fetch(searchTarget: .searchDailyBoxOffice,
                         queryItems: [QueryKeys.targetDate: Date.today]) {
            (networkResult: Result<BoxOfficeSearchResult, URLSessionNetworkServiceError>) -> Void in
            switch networkResult {
            case .success(let success):
                XCTAssertEqual(success.result.dailyList.count, 0)
                expects.fulfill()
            case .failure(let failure):
                XCTFail(failure.localizedDescription)
                expects.fulfill()
            }
        }
        wait(for: [expects], timeout: 5.0)
    }


}
