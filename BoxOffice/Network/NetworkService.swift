//
//  URLSessionNetworkService.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/17.
//

import Foundation

final class NetworkService: NetworkServiceProtocol {
    private enum HTTPMethod {
        static let get = "GET"
    }
    
    private let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetch<T: Decodable> (
        searchTarget: URLInfo,
        headers: [String: String]? = nil,
        queryItems: [String: String]? = nil,
        completion: @escaping (Result<T,
                               NetworkServiceError>) -> Void) {
        guard let urlComponent = establishURLComponents(searchTarget: searchTarget,
                                                        queryItems: queryItems),
              let url = urlComponent.url
        else {
            completion(.failure(.invalidURLError))
            return
        }
        print(url.description)
        let urlRequest = createHTTPRequest(of: url,
                                           with: headers,
                                           httpMethod: HTTPMethod.get)
        let task = session.dataTask(with: urlRequest) { data, response, error in
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
        var components = URLComponents()
        
        components.scheme = searchTarget.scheme
        components.host = searchTarget.host
        components.path = searchTarget.path
        components.queryItems = searchTarget.defaultQuery
        components.queryItems?.append(contentsOf: queries(items: queryItems))
        
        return components
    }
    
    private func queries(items: [String: String]?) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        
        guard let items = items else {
            return []
        }
        
        for item in items {
            let query = URLQueryItem(name: item.key, value: item.value)
            queryItems.append(query)
        }
        
        return queryItems
    }
    
    private func createHTTPRequest(of url: URL,
                                   with headers: [String: String]?,
                                   httpMethod: String,
                                   with body: Data? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod
        headers?.forEach({ header in
            request.addValue(header.value, forHTTPHeaderField: header.key)
        })
        
        if let body = body {
            request.httpBody = body
        }
        
        return request
    }
}
