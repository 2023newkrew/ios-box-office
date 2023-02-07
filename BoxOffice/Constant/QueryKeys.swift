//
//  QueryKeys.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import Foundation

enum QueryKeys {
    static let movieCode = "movieCd"
    static let targetDate = "targetDt"
    static let imageKeyQuery = "query"
    
    static func imageQuery(_ movieName: String) -> String {
        return "\(movieName) 영화 포스터"
    }
}
