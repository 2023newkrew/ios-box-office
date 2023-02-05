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
    let group: DispatchGroup?
    let baseURL: String
    let header: [String: String]
    let query: [URLQueryItem]
    let method: HTTPMethod
    
    init(session: URLSession = URLSession.shared,
         baseURL: String,
         header: [String: String] = [:],
         query: [URLQueryItem] = [],
         method: HTTPMethod = .get,
         queueGroup: DispatchGroup? = nil) {
        self.session = session
        self.baseURL = baseURL
        self.header = header
        self.query = query
        self.method = method
        
        self.group = queueGroup
    }
    
    init(session: URLSession = URLSession.shared,
         request: APIRequest,
         queueGroup: DispatchGroup? = nil) {
        self.session = session
        self.baseURL = request.urlString
        self.header = request.header
        self.query = request.query
        self.method = request.method
        
        self.group = queueGroup
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

extension APIProvider: URLSessionCallable {
    func startLoading(completionHandler completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.group?.enter()
        self.dataTask?.cancel()
        
        guard let urlRequest = self.urlRequest() else {
            return
        }
        
        self.dataTask = session.dataTask(with: urlRequest){ data, response, error in
            if error != nil {
                print("fail : ", error?.localizedDescription ?? "")
            }
            
            let successsRange = 200..<300
            if let statusCode = (response as? HTTPURLResponse)?.statusCode, successsRange.contains(statusCode) == false {
                print("error : ", (response as? HTTPURLResponse)?.statusCode ?? 0)
                print("msg : ", (response as? HTTPURLResponse)?.description ?? "")
            }
            
            completion(data, response, error)
            self.group?.leave()
        }
        
        self.dataTask?.resume()
    }
    
    func stopLoading() {
        self.dataTask?.cancel()
    }
}
