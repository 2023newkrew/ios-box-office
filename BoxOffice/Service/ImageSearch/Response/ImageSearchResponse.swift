//
//  ImageSearchResponse.swift
//  BoxOffice
//
//  Created by kakao on 2023/02/06.
//

import Foundation

struct ImageSearchResponse: Decodable {
    let documents: [Document]
}

struct Document: Decodable {
    let collection: String
    let datetime: String
    let displaySitename: String
    let docURL: String
    let height: Int
    let imageURL: String
    let thumbnailURL: String
    let width: Int

    enum CodingKeys: String, CodingKey {
        case collection, datetime
        case displaySitename = "display_sitename"
        case docURL = "doc_url"
        case height
        case imageURL = "image_url"
        case thumbnailURL = "thumbnail_url"
        case width
    }
}

extension Document {
    func toModel() -> PosterImage {
        return PosterImage(
            imageURLString: self.imageURL,
            thumbnailURLString: self.thumbnailURL,
            height: self.height,
            width: self.width
        )
    }
}
