//
//  APIDataTaskTests.swift
//  BoxOfficeTests
//
//  Created by john-lim on 2023/01/19.
//

import XCTest

final class APIDataTaskTests: XCTestCase {
    let session: URLSession = {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: config)
    }()
    
    func test_DailyBoxOfficeAPI_성공() {
        //given
        let request = APIRequest.getDailyBoxOffice(key: SecretKey.boxOfficeAPIKey ?? "",
                                                targetDate: "20120101")
        
        //when
        let apiProvider = APIProvider(session: session, request: request)
        
        //then
        Task {
            let result = await apiProvider.startAsyncLoading().success()
            
            do {
                guard let data = result?.data else {
                    XCTAssertNotNil(result?.data)
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
        let apiProvider = APIProvider(session: session, request: request)
        
        //then
        Task {
            let result = await apiProvider.startAsyncLoading().success()
            
            do {
                guard let data = result?.data else {
                    XCTAssertNotNil(result?.data)
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


