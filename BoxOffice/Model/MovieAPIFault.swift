//
//  MovieAPIFault.swift
//  BoxOffice
//
//  Created by john-lim on 2023/01/17.
//

import Foundation

struct MovieAPIFault: Decodable {
    let errorCode: String
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case info = "faultInfo"
    }
    
    enum InfoKeys: String, CodingKey {
        case errorCode
        case message
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let additionalInfo = try values.nestedContainer(keyedBy: InfoKeys.self, forKey: .info)
        errorCode = try additionalInfo.decode(String.self, forKey: .errorCode)
        message = try additionalInfo.decode(String.self, forKey: .message)
    }
}
