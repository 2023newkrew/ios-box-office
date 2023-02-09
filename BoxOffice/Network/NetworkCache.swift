//
//  NetworkCache.swift
//  BoxOffice
//
//  Created by john-lim on 2023/02/06.
//

import Foundation

enum NetworkCache {
    private enum MemoryCapacity {
        static let api = 1024 * 1024 * 10
        static let image = 1024 * 1024 * 30
    }
    
    static let api: URLCache = {
        if let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first,
           let target = URL(string: url.absoluteString + "preserved") {
            let cache = URLCache(memoryCapacity: MemoryCapacity.api,
                                 diskCapacity: MemoryCapacity.api * 3,
                                 directory: target)
            cache.removeAllCachedResponses()
            return cache
        }
        return URLCache()
    }()
    
    static let image = URLCache(memoryCapacity: MemoryCapacity.image,
                                diskCapacity: MemoryCapacity.image * 3)
}
