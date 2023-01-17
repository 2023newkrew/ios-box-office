//
//  CodingUtility.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/17.
//

import Foundation

class CodingUtility {
    func decode<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        let result = try decoder.decode(T.self, from: data)
        
        return result
    }
}
