//
//  CacheError.swift
//  BoxOffice
//
//  Created by kakao on 2023/02/09.
//

import Foundation

enum CacheError: Error {
    case absentCashedImage
    case inValidCashedImageData
}
