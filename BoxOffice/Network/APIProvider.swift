//
//  APIDataTaskProvider.swift
//  BoxOffice
//
//  Created by john-lim on 2023/01/17.
//

import Foundation

class APIProvider {
    struct APIResult {
        let data: Data?
        let response: URLResponse?
    }
    
    enum APIError: LocalizedError {
        case invalidRequest
        case apiConnectionFail(String)
        
        var errorDescription: String? {
            switch self {
            case .invalidRequest:
                return "URLRequest is nil"
            case let .apiConnectionFail(reason):
                return reason
            }
        }
    }
    
    private var session = {
        let config = URLSessionConfiguration.default
        config.urlCache = NetworkCache.api
        config.requestCachePolicy = .returnCacheDataElseLoad
        let session = URLSession.init(configuration: config)
        return session
    }()
    private let baseURL: String
    private let header: [String: String]
    private let query: [URLQueryItem]
    private let method: HTTPMethod
    
    init(session: URLSession? = nil,
         baseURL: String,
         header: [String: String] = [:],
         query: [URLQueryItem] = [],
         method: HTTPMethod = .get) {
        if let session = session {
            self.session = session
        }
        self.baseURL = baseURL
        self.header = header
        self.query = query
        self.method = method
    }
    
    init(session: URLSession? = nil,
         request: APIRequest) {
        if let session = session {
            self.session = session
        }
        self.baseURL = request.urlString
        self.header = request.header
        self.query = request.query
        self.method = request.method
    }
    
    private func urlRequest() -> URLRequest? {
        var urlComponents = URLComponents(string: self.baseURL)
        urlComponents?.queryItems = query
        
        guard let url = urlComponents?.url else {
            return nil
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = self.method.rawValue
        
        self.header.forEach { (key, value) in
            request.addValue(value, forHTTPHeaderField: key)
        }
        return request
    }
}

extension APIProvider {
    func startAsyncLoading() async -> Result<APIResult, APIError> {
        guard let urlRequest = self.urlRequest() else {
            return Result.failure(APIError.invalidRequest)
        }
        
        if let cachedResponse =  self.session.configuration.urlCache?.cachedResponse(for: urlRequest) {
            return Result.success(APIResult(data: cachedResponse.data,
                                            response: cachedResponse.response))
        }
        
        do {
            let (data, response) = try await self.session.data(for: urlRequest)
            self.session.configuration.urlCache?.storeCachedResponse(CachedURLResponse(response: response, data: data),
                                                                     for: urlRequest)
            return Result.success(APIResult(data: data, response: response))
        } catch {
            return Result.failure(APIError.apiConnectionFail(error.localizedDescription))
        }
    }
}


