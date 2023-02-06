//
//  NetworkCache.swift
//  BoxOffice
//
//  Created by john-lim on 2023/02/06.
//

import Foundation

enum NetworkCache {
    static let api: URLCache? = {
        if let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first,
           let target = URL(string: url.absoluteString + "preserved/") {
            return URLCache(memoryCapacity: 1024 * 1024 * 3,
                            diskCapacity: 1024 * 1024 * 10 * 3,
                            directory: target)
        }
        return nil
    }()
    
    static let image = URLCache(memoryCapacity: 1024 * 1024 * 10,
                                    diskCapacity: 1024 * 1024 * 100)
}
