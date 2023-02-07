//
//  ImageSearchAPIInformationOwner.swift
//  BoxOffice
//
//  Created by kakao on 2023/02/06.
//

import Foundation

protocol ImageSearchAPIInformationOwner {
    var serviceKey: String { get }
    var baseURLLiteral: String { get }
}

extension ImageSearchAPIInformationOwner {
    var serviceKey: String {
        return "15773251436a8b445e0fe226482dc4dc"
    }
    
    var baseURLLiteral: String {
        return "https://dapi.kakao.com/v2/search/"
    }
}
