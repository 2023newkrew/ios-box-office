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
    func load(api: API, yyyyMMdd: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let url = URL(string: api.url(yyyyMMdd: yyyyMMdd)) else {
            completion(.failure(.wrongURL))
            return
        }
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.some))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.wrongResponse))
                return
            }
            if let mimeType = httpResponse.mimeType,
                mimeType == "application/json",
                let data = data,
                let dataString = String(data: data, encoding: .utf8) {
                completion(.success(dataString))
            }
        }
        task.resume()
    }
}
