//
//  URLSessionNetworkService.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/17.
//

import Foundation

final class URLSessionNetworkService: URLSessionNetworkServiceProtocol {
    let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    private enum AppInfo {
        static var key: URLQueryItem {
            guard let filePath = Bundle.main.url(forResource: "Info", withExtension: "plist") else {
                fatalError()
            }
            guard let plist = NSDictionary(contentsOf: filePath) else {
                fatalError()
            }
            guard let key = plist.object(forKey: "APP_KEY") as? String else {
                fatalError()
            }
            return URLQueryItem(name: "key", value: key)
        }
    }
    
    func fetch<T: Decodable> (
        searchTarget: URLInfo,
        queryItems: [String: String]? = nil,
        completion: @escaping (Result<T,
                               URLSessionNetworkServiceError>) -> Void) {
        guard let urlComponent = URLComponentsGenerator(searchTarget: searchTarget,
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
    
    private func URLComponentsGenerator(searchTarget: URLInfo,
                                        queryItems: [String: String]?) -> URLComponents? {
        var components = URLComponents(string: searchTarget.urlString)
        components?.queryItems?.append(AppInfo.key)
        
        guard let queryItems = queryItems else {
            return components
        }
        for query in queryItems {
            components?.queryItems?.append(URLQueryItem(name: query.key, value: query.value))
        }
        return components
    }
}
