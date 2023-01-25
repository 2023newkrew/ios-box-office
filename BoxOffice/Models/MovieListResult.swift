//
//  MovieListResult.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/18.
//

import Foundation

struct MovieInfoDetailResult: Decodable {
    var movieInfoResult: MovieInfoResult
}

struct MovieInfoResult: Decodable {
    var movieInfo: MovieInfo
    var source: String
    
    enum CodingKeys: String, CodingKey {
        case movieInfo = "movieInfo"
        case source
    }
}

struct MovieInfo: Decodable {
    var movieCode: String
    var movieName: String
    var movieNameEnglish: String
    var movieNameOriginal: String
    var showTime: String
    var produceYear: String
    var openDate: String
    var produceStateName: String
    var typeName: String
    var nations: [Nations]
    var genres: [Genres]
    var directors: [Directors]
    var actors: [Actors]
    var showTypes: [ShowTypes]
    var companys: [Companys]
    var audits: [Audits]
    var staffs: [Staffs]
    
    enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case movieNameEnglish = "movieNmEn"
        case movieNameOriginal = "movieNmOg"
        case showTime = "showTm"
        case produceYear = "prdtYear"
        case openDate = "openDt"
        case produceStateName = "prdtStatNm"
        case typeName = "typeNm"
        case nations = "nations"
        case genres = "genres"
        case directors = "directors"
        case actors = "actors"
        case showTypes = "showTypes"
        case companys = "companys"
        case audits = "audits"
        case staffs = "staffs"
    }
}

struct Staffs: Decodable {
    var name: String
    var nameEnglish: String
    var roleName: String
    
    enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
        case nameEnglish = "peopleNmEn"
        case roleName = "staffRoleNm"
    }
}

struct Audits: Decodable {
    var number: String
    var watchGradeName: String
    
    enum CodingKeys: String, CodingKey {
        case number = "auditNo"
        case watchGradeName = "watchGradeNm"
    }
}

struct Companys: Decodable {
    var code: String
    var name: String
    var nameEnglish: String
    var partName: String
    
    enum CodingKeys: String, CodingKey {
        case code = "companyCd"
        case name = "companyNm"
        case nameEnglish = "companyNmEn"
        case partName = "companyPartNm"
    }
}

struct ShowTypes: Decodable {
    var name      : String
    var groupName : String
    
    enum CodingKeys: String, CodingKey {
        case name      = "showTypeNm"
        case groupName = "showTypeGroupNm"
    }
}

struct Actors: Decodable {
    var name   : String
    var nameEnglish : String
    var castName       : String
    var castNameEnglish     : String
    
    enum CodingKeys: String, CodingKey {
        case name   = "peopleNm"
        case nameEnglish = "peopleNmEn"
        case castName       = "cast"
        case castNameEnglish     = "castEn"
    }
}

struct Directors: Decodable {
    var name   : String
    var nameEnglish : String
    
    enum CodingKeys: String, CodingKey {
        case name   = "peopleNm"
        case nameEnglish = "peopleNmEn"
    }
}

struct Genres: Decodable {
    var name : String
    
    enum CodingKeys: String, CodingKey {
        case name = "genreNm"
    }
}

struct Nations: Decodable {
    var name : String
    
    enum CodingKeys: String, CodingKey {
        case name = "nationNm"
    }
}
