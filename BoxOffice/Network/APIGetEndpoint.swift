//
//  APIGetEndpoint.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import Foundation

protocol APIGetEndpoint: APIEndpoint { }

extension APIGetEndpoint {
    var method: HTTPMethod {
        return .get
    }
    var body: Data? {
        return nil
    }
}
