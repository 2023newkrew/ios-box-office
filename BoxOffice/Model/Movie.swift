//
//  Movie.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import Foundation

struct Movie: Decodable {
    let result: MovieResult
    
    enum CodingKeys: String, CodingKey {
        case result = "movieInfoResult"
    }
}

struct MovieResult: Decodable {
    let information: MovieInformation
    let source: String
    
    enum CodingKeys: String, CodingKey {
        case information = "movieInfo"
        case source
    }
}

struct MovieInformation: Decodable {
    let code: String
    let name: String
    let englishName: String
    let originalName: String
    let runningTime: String
    let productionYear: String
    let openDate: String
    let productionStateNme: String
    let type: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let showTypes: [ShowType]
    let companys: [Company]
    let audits: [Audit]
    let staffs: [Staff]

    enum CodingKeys: String, CodingKey {
        case code = "movieCd"
        case name = "movieNm"
        case englishName = "movieNmEn"
        case originalName = "movieNmOg"
        case runningTime = "showTm"
        case productionYear = "prdtYear"
        case openDate = "openDt"
        case productionStateNme = "prdtStatNm"
        case type = "typeNm"
        case nations, genres, directors, actors, showTypes, companys, audits, staffs
    }
}

struct Actor: Decodable {
    let name: String
    let englishName: String
    let caseName: String
    let englishCastName: String
    
    enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
        case englishName = "peopleNmEn"
        case caseName = "cast"
        case englishCastName = "castEn"
    }
}

struct Audit: Decodable {
    let number: String
    let watchGrade: String
    
    enum CodingKeys: String, CodingKey {
        case number = "auditNo"
        case watchGrade = "watchGradeNm"
    }
}

struct Company: Decodable {
    let code: String
    let name: String
    let englishName: String
    let partName: String

    enum CodingKeys: String, CodingKey {
        case code = "companyCd"
        case name = "companyNm"
        case englishName = "companyNmEn"
        case partName = "companyPartNm"
    }
}

struct Director: Decodable {
    let name: String
    let englishName: String
    
    enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
        case englishName = "peopleNmEn"
    }
}

struct Genre: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "genreNm"
    }
}

struct Nation: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "nationNm"
    }
}

struct ShowType: Decodable {
    let name: String
    let subtitle: String
    
    enum CodingKeys: String, CodingKey {
        case name = "showTypeGroupNm"
        case subtitle = "showTypeNm"
    }
}

struct Staff: Decodable {
    let name: String
    let englishName: String
    let role: String
    
    enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
        case englishName = "peopleNmEn"
        case role = "staffRoleNm"
    }
}
