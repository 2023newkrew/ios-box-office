//
//  AppKeys.swift
//  BoxOffice
//
//  Created by kakao on 2023/02/03.
//

import Foundation

enum AppKeys {
    static let boxOfficeAPI: [String: String]? = {
        guard let filePath = Bundle.main.url(forResource: "Info", withExtension: "plist") else {
            return nil
        }
        guard let plist = NSDictionary(contentsOf: filePath) else {
            return nil
        }
        guard let key = plist.object(forKey: "BOXOFFICE_APP_KEY") as? String else {
            return nil
        }
        return ["key": key]
    }()
    
    static let kakaoAPI: [String: String]? = {
        guard let filePath = Bundle.main.url(forResource: "Info", withExtension: "plist") else {
            return nil
        }
        guard let plist = NSDictionary(contentsOf: filePath) else {
            return nil
        }
        guard let key = plist.object(forKey: "KAKAO_APP_KEY") as? String else {
            return nil
        }
        return ["Authorization": "KakaoAK \(key)"]
    }()
}
