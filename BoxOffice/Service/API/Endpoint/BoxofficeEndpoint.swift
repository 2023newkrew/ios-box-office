//
//  BoxofficeEndpoint.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import Foundation

struct BoxofficeEndpoint: MovieAPIGetEndpoint {
    typealias APIResponse = BoxofficeResponse
    
    let path: String = "/boxoffice/searchDailyBoxOfficeList.json"
    let headers: [String : String]? = nil
    let date: Date
    let itemPerPage: Int?
    let movieType: MovieType?
    let nationType: NationType?
    let areaCode: String?
    var queries: [String: String?] {
        [
            "key": self.serviceKey,
            "targetDt": DateFormatter.yearMonthDay.string(from: self.date),
            "itemPerPage": String(self.itemPerPage ?? 10),
            "multiMovieYn": self.movieType?.typeCode,
            "repNationCd": self.nationType?.typeCode,
            "wideAreaCd": self.areaCode
        ]
    }
}

fileprivate extension NationType {
    var typeCode: String {
        switch self {
        case .korean:
            return "K"
        case .foreign:
            return "F"
        }
    }
}

fileprivate extension MovieType {
    var typeCode: String {
        switch self {
        case .diversity:
            return "Y"
        case .commerce:
            return "N"
        }
    }
}
