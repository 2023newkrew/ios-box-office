//
//  MovieDetailAPIResult.swift
//  BoxOffice
//
//  Created by john-lim on 2023/01/17.
//

import Foundation

struct MovieDetailResult: Decodable {
    let movieCode: String
    let movieName: String
    let movieEnglishName: String
    let movieNmOg: String
    let showTime: String
    let productYear: String
    let openYear: String
    let productStatus: String
    let typeName: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let showTypes: [ShowType]
    let companys: [Company]
    let audits: [Audit]
    let staffs: [Staff]
    let source: String
    
    enum CodingKeys: String, CodingKey {
        case result = "movieInfoResult"
    }
    
    enum ResultKeys: String, CodingKey {
        case info = "movieInfo"
        case source
    }
    
    enum InfoKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case movieEnglishName = "movieNmEn"
        case movieNmOg = "movieNmOg"
        case showTime = "showTm"
        case productYear = "prdtYear"
        case openYear = "openDt"
        case productStatus = "prdtStatNm"
        case typeName = "typeNm"
        case nations
        case genres
        case directors
        case actors
        case showTypes
        case companys
        case audits
        case staffs
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let results = try values.nestedContainer(keyedBy: ResultKeys.self, forKey: .result)
        let info = try results.nestedContainer(keyedBy: InfoKeys.self, forKey: .info)
                
        movieCode = try info.decode(String.self, forKey: .movieCode)
        movieName = try info.decode(String.self, forKey: .movieName)
        movieEnglishName = try info.decode(String.self, forKey: .movieEnglishName)
        movieNmOg = try info.decode(String.self, forKey: .movieNmOg)
        showTime = try info.decode(String.self, forKey: .showTime)
        productYear = try info.decode(String.self, forKey: .productYear)
        openYear = try info.decode(String.self, forKey: .openYear)
        productStatus = try info.decode(String.self, forKey: .productStatus)
        typeName = try info.decode(String.self, forKey: .typeName)
        nations = try info.decode([Nation].self, forKey: .nations)
        genres = try info.decode([Genre].self, forKey: .genres)
        directors = try info.decode([Director].self, forKey: .directors)
        actors = try info.decode([Actor].self, forKey: .actors)
        showTypes = try info.decode([ShowType].self, forKey: .showTypes)
        companys = try info.decode([Company].self, forKey: .companys)
        audits = try info.decode([Audit].self, forKey: .audits)
        staffs = try info.decode([Staff].self, forKey: .staffs)
        source = try results.decode(String.self, forKey: .source)
    }
    
    struct Actor: Decodable {
        let peopleName: String
        let peopleEnglishName: String
        let castingName: String
        let castingEnglishName: String
        
        enum CodingKeys: String, CodingKey {
            case peopleName = "peopleNm"
            case peopleEnglishName = "peopleNmEn"
            case castingName = "cast"
            case castingEnglishName = "castEn"
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
        let companyEnglishName: String
        let companyPartName: String
        
        enum CodingKeys: String, CodingKey {
            case companyCode = "companyCd"
            case companyName = "companyNm"
            case companyEnglishName = "companyNmEn"
            case companyPartName = "companyPartNm"
        }
    }
    
    struct Director: Decodable {
        let peopleName: String
        let peopleEnglishName: String
        
        enum CodingKeys: String, CodingKey {
            case peopleName = "peopleNm"
            case peopleEnglishName = "peopleNmEn"
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
        let name: String
        let englishName: String
        let roleName: String
        
        enum CodingKeys: String, CodingKey {
            case name = "peopleNm"
            case englishName = "peopleNmEn"
            case roleName = "staffRoleNm"
        }
    }
}


