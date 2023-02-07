//
//  MovieInfo.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/31.
//

import Foundation

struct Movie {
    let movieCode: String
    let movieName: String
    let movieNameEnglish: String
    let movieNameOriginal: String
    let showTime: String
    let productionYear: String
    let openDate: Date?
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let audits: [Audit]
}
