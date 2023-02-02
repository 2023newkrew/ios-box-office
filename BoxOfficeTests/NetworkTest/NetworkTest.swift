//
//  NetworkTest.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/21.
//

import XCTest

final class NetworkTest: XCTestCase {
    var sut: NetworkServiceProtocol!
    
    override func setUp() {
        sut = NetworkService()
    }
    
    func test_영화_내용_잘_받아_오는_지() {
        let expects = XCTestExpectation(description: "영화 정보 TEST Expecatation")
        
        sut.fetch(searchTarget: .searchDetailMovieInfo,
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
    
    func test_오늘_BoxOffice_잘_받아오는_지_타입() {
        let expects = XCTestExpectation(description: "오늘의 박스 오피스 TEST Expecatation")
        
        sut.fetch(searchTarget: .searchDailyBoxOffice,
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
    
    func test_오늘_BoxOffice_잘_받아오는_지_날짜() {
        let expects = XCTestExpectation(description: "오늘의 박스 오피스 TEST Expecatation")
        
        sut.fetch(searchTarget: .searchDailyBoxOffice,
                  headers: nil,
                  queryItems: [QueryKeys.targetDate: Date.dayString(.yesterday, format: .yyyyMMdd)]) {
            (networkResult: Result<BoxOfficeSearchResult, NetworkServiceError>) -> Void in
            switch networkResult {
            case .success(let success):
                let today = Date.dayString(.yesterday, format: .yyyyMMdd)
                XCTAssertEqual(success.result.searchRange, "\(today)~\(today)")
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
                  headers: nil,
                  queryItems: [QueryKeys.targetDate: Date.dayString(.today, format: .yyyyMMdd)]) {
            (networkResult: Result<BoxOfficeSearchResult, NetworkServiceError>) -> Void in
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
    
    func test_images_잘_받아_오나() {
        let expects = XCTestExpectation(description: "오늘의 이미지 렌더링")
        
        sut.fetch(searchTarget: .searchMoviePosterImage,
                  headers: AppKeys.kakaoAPI,
                  queryItems: ["query": "슬램덩크 영화 포스터"]) {
            (networkResult: Result<ImageSearchResult, NetworkServiceError>) -> Void in
            switch networkResult {
            case .success(let success):
                print(success)
                expects.fulfill()
            case .failure(let failure):
                XCTFail()
                expects.fulfill()
            }
        }
        wait(for: [expects], timeout: 5.0)
    }
}
