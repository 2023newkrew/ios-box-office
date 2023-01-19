//
//  NetworkError.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case serverError(description: String)
    case invalidResponse
    case invalidStatusCode(code: Int, data: Data)
    case invalidData
    case parsingFailure(decodingError: DecodingError?, data: Data)
}
