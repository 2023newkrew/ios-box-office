//
//  URLSessionNetworkServiceProtocol.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/18.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetch<T: Decodable> (
        searchTarget: URLInfo,
        queryItems: [String: String]?,
        completion: @escaping (Result<T, URLSessionNetworkServiceError>) -> Void
    )
}
