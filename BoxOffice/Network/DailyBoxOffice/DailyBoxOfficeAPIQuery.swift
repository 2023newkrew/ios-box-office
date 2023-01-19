//
//  DailyBoxOfficeAPIQuery.swift
//  BoxOffice
//
//  Created by john-lim on 2023/01/17.
//

import Foundation

struct DailyBoxOfficeAPIQuery: QueryItems{
    var items: [URLQueryItem]
    
    init(key: String,
         targetDate: String,
         itemPerPage: Int? = nil,
         enableMultiMovie: String? = nil,
         nationSelectCode: String? = nil,
         areaCode: String? = nil) {
        
        var items: [URLQueryItem] = []
        items.append(URLQueryItem(name: "key", value: key))
        items.append(URLQueryItem(name: "targetDt", value: targetDate))
        if let itemPerPage = itemPerPage {
            items.append(URLQueryItem(name: "itemPerPage", value: String(itemPerPage)))
        }
        items.append(URLQueryItem(name: "multiMovieYn", value: enableMultiMovie))
        items.append(URLQueryItem(name: "repNationCd", value: nationSelectCode))
        items.append(URLQueryItem(name: "wideAreaCd", value: areaCode))
        self.items = items
    }
}
