//
//  MovieDetailAPIQuery.swift
//  BoxOffice
//
//  Created by john-lim on 2023/01/17.
//

import Foundation

struct MovieDetailAPIQuery: QueryItems{
    let items: [URLQueryItem]
    
    init(key: String,
         movieCode: String) {
        var items: [URLQueryItem] = []
        items.append(URLQueryItem(name: "key", value: key))
        items.append(URLQueryItem(name: "movieCd", value: movieCode))
        self.items = items
    }
}
