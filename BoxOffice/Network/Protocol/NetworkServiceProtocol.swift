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
        headers: [String: String]?,
        queryItems: [String: String]?,
        completion: @escaping (Result<T, NetworkServiceError>) -> Void
    )
}
