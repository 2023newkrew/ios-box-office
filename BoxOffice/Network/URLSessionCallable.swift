//
//  URLSessionCallable.swift
//  BoxOffice
//
//  Created by john-lim on 2023/01/19.
//

import Foundation

protocol URLSessionCallable {
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionCallable {
}
