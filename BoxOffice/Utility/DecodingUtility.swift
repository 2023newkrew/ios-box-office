//
//  DecodingUtility.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import Foundation

protocol DecodingUtility {
    func decode<T: Decodable>(data: Data) throws -> T
}
