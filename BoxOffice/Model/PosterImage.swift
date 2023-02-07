//
//  PosterImage.swift
//  BoxOffice
//
//  Created by kakao on 2023/02/07.
//

import Foundation

struct PosterImage {
    let imageURL: String
    let thumbnailURL: String
    let height: Int
    let width: Int
}

extension PosterImage {
    var aspectRatio: Double {
        return Double(self.height) / Double(self.width)
    }
}
