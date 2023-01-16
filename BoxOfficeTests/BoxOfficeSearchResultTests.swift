//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by john-lim on 2023/01/16.
//

import XCTest

final class BoxOfficeSearchResultParsingTests: XCTestCase {
    let data = NSDataAsset(name: "SampleData", bundle: Bundle(for: ViewController.self))?.data
    
    func test_데이터불러오기테스트(){
        XCTAssertNotNil(data)
    }
    
    func test_JSONSerialization테스트(){
        guard let data = data else {
            XCTAssertTrue(false)
            return
        }
        guard let parsed = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
            XCTAssertTrue(false)
            return
        }
        print(parsed)
        XCTAssertNotNil(parsed)
    }
    
    func test_JSONDecoder로Model파싱테스트(){
        guard let data = data else {
            XCTAssertTrue(false)
            return
        }
        do{
            let parsed = try JSONDecoder().decode(BoxOfficeSearchResult.self, from: data)
            print(parsed)
            XCTAssertNotNil(parsed)
        }catch {
            print("error",error)
            XCTAssertTrue(false)
            return
        }
    }
}
