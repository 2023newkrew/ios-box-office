//
//  ImageService.swift
//  BoxOffice
//
//  Created by kakao on 2023/02/06.
//

import Foundation

protocol ImageService {
    var networkProvider: NetworkProvider { get }
    
    @discardableResult
    func fetchPosterImage(
        for query: String,
        completion: @escaping (Result<PosterImage, NetworkError>) -> Void
    ) -> Cancellable?
}

class DefaultImageService: ImageService {
    let networkProvider: NetworkProvider = DefaultNetworkProvider()
    
    func fetchPosterImage(
        for query: String,
        completion: @escaping (Result<PosterImage, NetworkError>) -> Void
    ) -> Cancellable? {
        let endpoint = ImageSearchEndpoint(
            query: query + " 영화 포스터"
        )
        return self.networkProvider.request(endpoint) { result in
            completion(result.map { $0.documents[0].toModel() })
        }
    }
}
