//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by john-lim on 2023/01/16.
//

import XCTest

final class BoxOfficeSearchResultParsingTests: XCTestCase {
    let data = NSDataAsset(name: "SampleData", bundle: Bundle(for: ViewController.self))?.data
    
    func test_데이터불러오기테스트() {
        XCTAssertNotNil(data)
    }
    
    func test_JSONSerialization테스트() {
        guard let data = data else {
            XCTAssertTrue(false)
            return
        }
        do {
            let parsed = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            XCTAssertNotNil(parsed)
        } catch {
            print("error",error)
            XCTAssertTrue(false)
            return
        }
    }
    
    func test_JSONDecoder로Model파싱테스트() {
        guard let data = data else {
            XCTAssertTrue(false)
            return
        }
        do {
            let parsed = try JSONDecoder().decode(DailyBoxOfficeSearchResult.self, from: data)
            XCTAssertNotNil(parsed)
        } catch {
            print("error",error)
            XCTAssertTrue(false)
            return
        }
    }
}
