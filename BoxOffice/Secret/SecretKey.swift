//
//  SecretKey.swift
//  BoxOffice
//
//  Created by john-lim on 2023/01/17.
//

import Foundation

enum SecretKey {
    private static let secretKeys: NSDictionary? = {
        guard let url = Bundle.main
            .url(forResource: "Secret", withExtension: "plist") else {
            return nil
        }
        guard let keys = NSDictionary(contentsOf: url) else {
            return nil
        }
        return keys
    }()
    
    static let dailyBoxOfficeAPIKey = secretKeys?["DailyBoxOfficeAPIKey"] as? String
}
