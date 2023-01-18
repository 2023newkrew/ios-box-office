//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by kakao on 2023/01/16.
//

import XCTest

final class BoxOfficeResultTests: XCTestCase {

    func test_파싱_해보기() {
        guard let json = NSDataAsset(name: "boxOfficeResult") else {
            XCTFail("Data Error")
            return
        }
        let data = json.data
        do {
            let boxOfficeSearchResult = try JSONDecoder().decode(BoxOfficeSearchResult.self, from: data)
            XCTAssertGreaterThan(boxOfficeSearchResult.result.dailyList.count, 0)
        } catch {
            XCTFail()
        }
    }
}
