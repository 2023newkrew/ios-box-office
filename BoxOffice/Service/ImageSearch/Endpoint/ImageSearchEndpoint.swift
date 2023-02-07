//
//  ImageSearchEndpoint.swift
//  BoxOffice
//
//  Created by kakao on 2023/02/06.
//

import Foundation

struct ImageSearchEndpoint: ImageSearchAPIEndpoint {
    typealias APIResponse = ImageSearchResponse
    
    enum SortDescription: String {
        case accuracy
        case recency
    }

    let method: HTTPMethod = .get
    let path: String = "image"
    let query: String
    let sortDescription: SortDescription = .accuracy
    let page: Int = 1
    let size: Int = 1
    var headers: [String: String]? {
        return ["Authorization": "KakaoAK" + " \(self.serviceKey)"]
    }
    var queries: [String: String?] {
        return [
            "query": self.query,
            "sort": self.sortDescription.rawValue,
            "page": String(self.page),
            "size": String(self.size)
        ]
    }
    
    let body: Data? = nil
}
