//
//  URLSessionNetworkService.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/17.
//

import Foundation

final class URLSessionNetworkService: URLSessionNetworkServiceProtocol {
    private let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetch<T: Decodable> (
        searchTarget: URLInfo,
        queryItems: [String: String]? = nil,
        completion: @escaping (Result<T,
                               URLSessionNetworkServiceError>) -> Void) {
        guard let urlComponent = establishURLComponents(searchTarget: searchTarget,
                                                        queryItems: queryItems),
              let url = urlComponent.url
        else {
            completion(.failure(.invalidURLError))
            return
        }

        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.transportError))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.transportError))
                return
            }
            guard (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(.serverError(code: httpResponse.statusCode)))
                return
            }
            guard let data = data else {
                completion(.failure(.emptyDataError))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
    
    private func establishURLComponents(searchTarget: URLInfo,
                                        queryItems: [String: String]?) -> URLComponents? {
        var components = URLComponents(string: URLInfo.baseURL)
        components?.path = searchTarget.path
        
        guard let appKey = URLInfo.key, let queryItems = queryItems else {
            return nil
        }
        
        var queries: [URLQueryItem] = [appKey]
        
        for query in queryItems {
            let item = URLQueryItem(name: query.key, value: query.value)
            queries.append(item)
        }
        components?.queryItems = queries
        
        return components
    }
}
