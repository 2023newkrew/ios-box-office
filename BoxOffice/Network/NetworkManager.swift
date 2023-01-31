//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import Foundation

enum NetworkError: Error {
    case wrongURL
    case some
    case wrongResponse
}

class NetworkManager {
    func apiURL(api: API, yyyyMMdd: String) -> URL? {
        return URL(string: api.finalURL(yyyyMMdd: yyyyMMdd))
    }
    
    func load(url: URL?, completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let url = url else {
            return completion(.failure(.wrongURL))
        }
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                return completion(.failure(.some))
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                return completion(.failure(.wrongResponse))
            }
            if let mimeType = httpResponse.mimeType,
                mimeType == "application/json",
                let data = data,
                let dataString = String(data: data, encoding: .utf8) {
                return completion(.success(dataString))
            }
        }
        task.resume()
    }
}
