//
//  APIDataTaskProvider.swift
//  BoxOffice
//
//  Created by john-lim on 2023/01/17.
//

import Foundation

class APIProvider {
    let session: URLSession
    var dataTask: URLSessionDataTask?
    let baseURL: String
    let query: [URLQueryItem]?
    let method: HTTPMethod
    
    init(session: URLSession = URLSession.shared,
         baseURL: String,
         query: [URLQueryItem]? = nil,
         method: HTTPMethod = .get) {
        
        self.session = session
        self.baseURL = baseURL
        self.query = query
        self.method = method
    }
    
    init(session: URLSession = URLSession.shared,
         request: APIRequest) {
        
        self.session = session
        self.baseURL = request.urlString
        self.query = request.query
        self.method = request.method
    }
    
    private func urlRequest() -> URLRequest? {
        var urlComponents = URLComponents(string: self.baseURL)
        if let query = self.query {
            urlComponents?.queryItems = query
        }
        guard let url = urlComponents?.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        return request
    }
}

extension APIProvider: URLSessionCallable {
    func startLoading(completionHandler completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.dataTask?.cancel()
        
        guard let urlRequest = self.urlRequest() else {
            return
        }
        
        self.dataTask = session.dataTask(with: urlRequest){ data, response, error in
            guard error == nil else {
                print("fail : ", error?.localizedDescription ?? "")
                return
            }
            
            let successsRange = 200..<300
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, successsRange.contains(statusCode)
            else {
                print("error : ", (response as? HTTPURLResponse)?.statusCode ?? 0)
                print("msg : ", (response as? HTTPURLResponse)?.description ?? "")
                return
            }
            
            guard let data = data else {
                return
            }
            completion(data, response, error)
        }
        
        self.dataTask?.resume()
    }
    
    func stopLoading() {
        self.dataTask?.cancel()
    }
}
