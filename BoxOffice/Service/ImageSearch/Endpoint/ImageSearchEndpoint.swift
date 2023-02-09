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
    
    init(query: String, sort: SortDescription = .accuracy, page: Int = 1, size: Int = 1) {
        self.queries = [
            "query": query,
            "sort": sort.rawValue,
            "page": String(page),
            "size": String(size)
        ]
    }

    let method: HTTPMethod = .get
    let path: String = "image"
    var headers: [String: String]? {
        return ["Authorization": "KakaoAK" + " \(self.serviceKey)"]
    }

    let queries: [String: String?]
    let body: Data? = nil
}
