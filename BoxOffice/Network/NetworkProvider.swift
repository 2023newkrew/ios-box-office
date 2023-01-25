//
//  NetworkProvider.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import Foundation

protocol NetworkProvider {
    var session: URLSessionable { get }
    var decoder: DecodingUtility { get }
    func request<T: APIEndpoint>(
        _ request: T,
        completion: @escaping (Result<T.APIResponse, NetworkError>) -> Void
    ) -> Cancellable?
}

extension NetworkProvider {
    func request<T: APIEndpoint>(
        _ request: T,
        completion: @escaping (Result<T.APIResponse, NetworkError>) -> Void
    ) -> Cancellable? {
        guard let urlRequest = request.urlRequest else {
            completion(.failure(.invalidRequest))
            return nil
        }
        
        let task = self.session.dataTask(with: urlRequest) { data, response, error in
            if let error {
                completion(.failure(.serverError(description: error.localizedDescription)))
                return
            }
            
            guard let data else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                completion(.failure(.invalidStatusCode(code: response.statusCode, data: data)))
                return
            }
            
            do {
                let decoded: T.APIResponse = try self.decoder.decode(data: data)
                completion(.success(decoded))
                return
            } catch let error {
                let decodingError = error as? DecodingError
                completion(.failure(.parsingFailure(decodingError: decodingError, data: data)))
                return
            }
        }
        task.resume()
        
        return task
    }
}

