//
//  URLSessionNetworkServiceError.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/17.
//

import Foundation

enum URLSessionNetworkServiceError: Error {
    case invalidURLError
    case transportError
    case serverError(code: Int)
    case emptyDataError
    case decodingError
    case unknownError
}

extension URLSessionNetworkServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURLError:
            return "잘못된 주소 입니다."
        case .transportError:
            return "전송에러가 발생했습니다."
        case .serverError(let code):
            return "서버에 에러가 발생했습니다 Code: \(code)"
        case .emptyDataError:
            return "데이터가 비어있습니다."
        case .decodingError:
            return "디코딩 실패"
        case .unknownError:
            return "이유 불명의 에러 발생"
        }
    }
}
