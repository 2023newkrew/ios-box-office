//
//  ImageSearchResult.swift
//  BoxOffice
//
//  Created by john-lim on 2023/02/02.
//

import Foundation

struct ImageSearchResult: Decodable {
    let documents: [Document]
    let isEnd: Bool
    let pagableCount: Int
    let totalCount: Int
    
    enum BaseKeys: String, CodingKey {
        case documents
        case meta
    }
    
    enum MetaKeys: String, CodingKey {
        case isEnd = "is_end"
        case pagableCount = "pageable_count"
        case totalCount = "total_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: BaseKeys.self)
        let meta = try values.nestedContainer(keyedBy: MetaKeys.self, forKey: .meta)
        
        self.documents = try values.decode([Document].self, forKey: .documents)
        self.isEnd = try meta.decode(Bool.self, forKey: .isEnd)
        self.pagableCount = try meta.decode(Int.self, forKey: .pagableCount)
        self.totalCount = try meta.decode(Int.self, forKey: .totalCount)
    }
    
    struct Document: Decodable {
        let collection: String
        let datetime: String
        let siteName: String
        let documentURL: String
        let imageURL: String
        let thumbnailURL: String
        let height: Int
        let width: Int
        
        enum CodingKeys: String, CodingKey {
            case collection
            case datetime
            case siteName = "display_sitename"
            case documentURL = "doc_url"
            case imageURL = "image_url"
            case thumbnailURL = "thumbnail_url"
            case height = "height"
            case width = "width"
        }
    }
}
