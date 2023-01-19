//
//  MovieInformationResponse.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import Foundation

struct MovieInformationResponse: Decodable {
    let movieInformationResult: MovieInfoResult
    
    enum CodingKeys: String, CodingKey {
        case movieInformationResult = "movieInfoResult"
    }
}

struct MovieInfoResult: Decodable {
    let movieInformation: MovieInfo
    let source: String
    
    enum CodingKeys: String, CodingKey {
        case movieInformation = "movieInfo"
        case source
    }
}

struct MovieInfo: Decodable {
    let movieCode: String
    let movieName: String
    let movieNameEnglish: String
    let movieNameOriginal: String
    let showTime: String
    let productionYear: String
    let openDate: String
    let productionStateName: String
    let typeName: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let showTypes: [ShowType]
    let companies: [Company]
    let audits: [Audit]
    let staffs: [Staff]
    
    enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case movieNameEnglish = "movieNmEn"
        case movieNameOriginal = "movieNmOg"
        case showTime = "showTm"
        case productionYear = "prdtYear"
        case openDate = "openDt"
        case productionStateName = "prdtStatNm"
        case typeName = "typeNm"
        case nations
        case genres
        case directors
        case actors
        case showTypes
        case companies = "companys"
        case audits
        case staffs
    }
}

struct Actor: Decodable {
    let peopleName: String
    let peopleNameEnglish: String
    let cast: String
    let castEnglish: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameEnglish = "peopleNmEn"
        case cast
        case castEnglish = "castEn"
    }
}

struct Audit: Decodable {
    let auditNumber: String
    let watchGradeName: String
    
    enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case watchGradeName = "watchGradeNm"
    }
}

struct Company: Decodable {
    let companyCode: String
    let companyName: String
    let companyNameEnglish: String
    let companyPartName: String
    
    enum CodingKeys: String, CodingKey {
        case companyCode = "companyCd"
        case companyName = "companyNm"
        case companyNameEnglish = "companyNmEn"
        case companyPartName = "companyPartNm"
    }
}

struct Director: Decodable {
    let peopleName: String
    let peopleNameEnglish: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameEnglish = "peopleNmEn"
    }
}

struct Genre: Decodable {
    let genreName: String
    
    enum CodingKeys: String, CodingKey {
        case genreName = "genreNm"
    }
}

struct Nation: Decodable {
    let nationName: String
    
    enum CodingKeys: String, CodingKey {
        case nationName = "nationNm"
    }
}

struct ShowType: Decodable {
    let showTypeGroupName: String
    let showTypeName: String
    
    enum CodingKeys: String, CodingKey {
        case showTypeGroupName = "showTypeGroupNm"
        case showTypeName = "showTypeNm"
    }
}

struct Staff: Decodable {
    let peopleName: String
    let peopleNameEnglish: String
    let staffRoleName: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleNameEnglish = "peopleNmEn"
        case staffRoleName = "staffRoleNm"
    }
}
