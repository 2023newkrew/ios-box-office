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
        let request = APIRequest.getDailyBoxOffice(key: SecretKey.boxOfficeAPIKey ?? "",
                                                targetDate: "20120101")
        
        //when
        let apiProvider = MockAPIProvider(request: request)
        
        //then
        apiProvider.startLoading { data, _, _ in
            do {
                guard let data = data else {
                    XCTAssertNotNil(data)
                    return
                }
                
                let parsed = try JSONDecoder().decode(DailyBoxOfficeSearchResult.self, from: data)
                XCTAssertNotNil(parsed)
                XCTAssertEqual(parsed.dailyList.count, 10)
                XCTAssertEqual(parsed.searchRange, "20120101~20120101")
                XCTAssertTrue(parsed.dailyList.contains(where: { dailyOffice in
                    dailyOffice.movieName == "미션임파서블:고스트프로토콜"
                }))
            } catch {
                print("error", error)
                XCTAssertTrue(false)
                return
            }
        }
    }
    
    func test_MovieDetailAPI_성공() {
        //given
        let request = APIRequest.getMovieDetail(key: SecretKey.boxOfficeAPIKey ?? "",
                                                   movieCode: "20194403")
        
        //when
        let apiProvider = MockAPIProvider(request: request)
        
        //then
        apiProvider.startLoading { data, _, _ in
            do {
                guard let data = data else {
                    XCTAssertNotNil(data)
                    return
                }
                
                let parsed = try JSONDecoder().decode(MovieDetailResult.self, from: data)
                XCTAssertNotNil(parsed)
                XCTAssertEqual(parsed.movieName, "광해, 왕이 된 남자")
                XCTAssertEqual(parsed.staffs.count, 345)
            } catch {
                print("error", error)
                XCTAssertTrue(false)
                return
            }
        }
    }
}


