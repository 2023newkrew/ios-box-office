//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by kakao on 2023/01/17.
//

import XCTest

class JsonDecodingTests: XCTestCase {
    private enum Constant {
        static let boxOfficeSample = "box_office_sample"
        static let json = "json"
        static let boxOfficeSampleFileMissing = "Missing file: box_office_sample.json"
    }
    
    func testDailyBoxOfficeDecoding() throws {
        guard let fileLocation = Bundle.main.url(forResource: Constant.boxOfficeSample, withExtension: Constant.json) else {
            XCTFail(Constant.boxOfficeSampleFileMissing)
            return
        }
        
        let decoder = JSONDecoder()
        let jsonData = try Data(contentsOf: fileLocation)
        XCTAssertNotNil(jsonData)
        
        let dailyBoxOffice: DailyBoxOffice = try decoder.decode(DailyBoxOffice.self, from: jsonData)
        XCTAssertNotNil(dailyBoxOffice)
    }
}
