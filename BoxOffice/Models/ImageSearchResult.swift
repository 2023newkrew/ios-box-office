//
//  ImageSearchResult.swift
//  BoxOffice
//
//  Created by kakao on 2023/02/03.
//

import Foundation

struct ImageSearchResult: Decodable {
    var imageInfos : [ImageInfo]
    
    enum CodingKeys: String, CodingKey {
        case imageInfos = "documents"
        
    }
}

struct ImageInfo: Codable {
    var collection      : String
    var thumbnailUrl    : String
    var imageUrl        : String
    var width           : Int
    var height          : Int
    var displaySitename : String
    var docUrl          : String
    var datetime        : String
    
    enum CodingKeys: String, CodingKey {
        case collection      = "collection"
        case thumbnailUrl    = "thumbnail_url"
        case imageUrl        = "image_url"
        case width           = "width"
        case height          = "height"
        case displaySitename = "display_sitename"
        case docUrl          = "doc_url"
        case datetime        = "datetime"
    }
}
