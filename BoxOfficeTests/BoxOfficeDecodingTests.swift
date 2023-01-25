//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by kakao on 2023/01/17.
//

import XCTest

final class BoxOfficeDecodingTests: XCTestCase {
    let sut = JSONDecodingUtility()
    var jsonData: NSDataAsset?
    
    override func setUpWithError() throws {
        self.jsonData = NSDataAsset(name: "box_office_sample")
    }

    func test_decode_sample() throws {
        guard let jsonData = self.jsonData else {
            XCTFail("wrong JSON data")
            return
        }

        do {
            let decoded: BoxofficeResponse = try self.sut.decode(data: jsonData.data)
            print(decoded)
        } catch let error as DecodingError {
            XCTFail("parsing fail: \(error.localizedDescription)")
        }
    }
}
