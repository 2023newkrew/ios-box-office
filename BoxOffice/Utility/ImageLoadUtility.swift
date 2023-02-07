//
//  ImageLoadUtility.swift
//  BoxOffice
//
//  Created by kakao on 2023/02/07.
//

import Foundation

final class ImageLoadUtility {
    static let imageCache = URLCache(
        memoryCapacity: 300 * 1024 * 1024,
        diskCapacity: 1000 * 1024 * 1024,
        directory: cacheDirectory
    )

    private static let cacheDirectory: URL? = {
        let url = try? FileManager.default.url(
            for: .cachesDirectory,
            in: .allDomainsMask,
            appropriateFor: nil,
            create: false
        )
        return url
    }()

    static func fetchImage(imageURL: URL, completionHandler: @escaping (Data) -> Void) {
        let request = URLRequest(url: imageURL)

        self.loadImageFromCache(request: request) { result in
            switch result {
            case .success(let imageData):
                completionHandler(imageData)
            case .failure:
                self.downloadImage(request: request) { imageData in
                    completionHandler(imageData)
                }
            }
        }
    }

    private static func downloadImage(
        request: URLRequest,
        completionHandler: @escaping (Data) -> Void
    ) {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, _ in
            guard let data = data else {
                return
            }
            guard let response = response as? HTTPURLResponse,
                    (200...299).contains(response.statusCode) else {
                return
            }
            let cachedResponse = CachedURLResponse(response: response, data: data)
            self.imageCache.storeCachedResponse(cachedResponse, for: request)

            completionHandler(data)

        }
        dataTask.resume()
    }
    
    private static func loadImageFromCache(
        request: URLRequest,
        completionHandler: @escaping (Result<Data, CacheError>) -> Void
    ) {
        if let imageData = self.imageCache.cachedResponse(for: request)?.data {
            completionHandler(.success(imageData))
        } else {
            completionHandler(.failure(.absentCashedImage))
        }
    }
}

enum CacheError: Error {
    case absentCashedImage
    case inValidCashedImageData
}
