//
//  MovieAPIInformationOwner.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import Foundation

protocol MovieAPIInformationOwner {
    var serviceKey: String { get }
    var baseURLLiteral: String { get }
}

extension MovieAPIInformationOwner {
    var serviceKey: String {
        return "5e32c96003dbadd20b5a1db7a15d38c8"
    }
    
    var baseURLLiteral: String {
        return "https://www.kobis.or.kr/kobisopenapi/webservice/rest"
    }
}
