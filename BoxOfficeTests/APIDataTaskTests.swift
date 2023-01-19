//
//  APIDataTaskTests.swift
//  BoxOfficeTests
//
//  Created by john-lim on 2023/01/19.
//

import XCTest

final class APIDataTaskTests: XCTestCase {
    let mockURLString = "https://camp.yagom-academy.kr/mock/test"

    func test_DailyBoxOfficeAPI_성공() {
        //given
        guard let data = NSDataAsset(name: "DailyBoxOfficeAPITestData",
                                     bundle: Bundle(for: APIDataTaskTests.self))?.data else {
            XCTAssertTrue(false)
            return
        }
        guard let mockURL = URL(string: mockURLString) else {
            XCTAssertTrue(false)
            return
        }
        let response = HTTPURLResponse(url: mockURL,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)
        let session = MockURLSession(data: data, urlResponse: response, error: nil)
        
        let query = DailyBoxOfficeAPIQuery(key: SecretKey.boxOfficeAPIKey ?? "", targetDate: "20120101")
        let dailyBoxOfficeAPI = DailyBoxOfficeAPI(session: session, query: query)
        
        //when
        let dataTask = dailyBoxOfficeAPI.dataTask { data in
            do {
                let parsed = try JSONDecoder().decode(DailyBoxOfficeSearchResult.self, from: data)
                XCTAssertNotNil(parsed)
            } catch {
                print("error", error)
                XCTAssertTrue(false)
                return
            }
        }
        
        //then
        dataTask?.resume()
    }
    
    func test_MovieDetailAPI_성공() {
        //given
        guard let data = NSDataAsset(name: "MovieDetailAPITestData",
                                     bundle: Bundle(for: APIDataTaskTests.self))?.data else {
            XCTAssertTrue(false)
            return
        }
        guard let mockURL = URL(string: mockURLString) else {
            XCTAssertTrue(false)
            return
        }
        let response = HTTPURLResponse(url: mockURL,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)
        let session = MockURLSession(data: data, urlResponse: response, error: nil)
        
        let query = MovieDetailAPIQuery(key: SecretKey.boxOfficeAPIKey ?? "", movieCode: "20194403")
        let movieDetailAPI = MovieDetailAPI(session: session, query: query)
        
        //when
        let dataTask = movieDetailAPI.dataTask { data in
            do {
                let parsed = try JSONDecoder().decode(MovieDetailResult.self, from: data)
                XCTAssertNotNil(parsed)
            } catch {
                print("error", error)
                XCTAssertTrue(false)
                return
            }
        }
        
        //then
        dataTask?.resume()
    }
}


