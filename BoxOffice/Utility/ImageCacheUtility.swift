//
//  ImageDownLoadUtility.swift
//  BoxOffice
//
//  Created by kakao on 2023/02/09.
//

import Foundation

final class ImageCacheUtility {
    private init() {}
    static let imageCache = URLCache(memoryCapacity: 30 * 1024 * 1024,
                                     diskCapacity: 10 * 1024 * 1024,
                                     directory: cacheDirectory)
    private static let cacheDirectory: URL? = {
        let url = try? FileManager.default.url(for: .cachesDirectory,
                                               in: .allDomainsMask,
                                               appropriateFor: nil,
                                               create: false)
        return url
    }()
    
    static func fetchImage(imageURL: URL, completion: @escaping (Data) -> Void) {
        let request = URLRequest(url: imageURL)
        
        self.loadImageFromCache(request: request) { result in
            switch result {
            case .success(let imageData):
                completion(imageData)
            case .failure:
                self.downloadImage(request: request) { imageData in
                    completion(imageData)
                }
            }
        }
    }
    
    private static func downloadImage(
        request: URLRequest,
        completion: @escaping (Data) -> Void
    ) {
        let task = URLSession.shared.dataTask(with: request) { data, response, _ in
            guard let data = data else {
                return
            }
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                return
            }
            let cachedResponse = CachedURLResponse(response: response, data: data)
            imageCache.storeCachedResponse(cachedResponse, for: request)
            
            completion(data)
        }
        task.resume()
    }
    
    private static func loadImageFromCache(
        request: URLRequest,
        completion: @escaping (Result<Data, CacheError>) -> Void
    ) {
        if let imageData = imageCache.cachedResponse(for: request)?.data {
            completion(.success(imageData))
        } else {
            completion(.failure(.absentCashedImage))
        }
    }
}
