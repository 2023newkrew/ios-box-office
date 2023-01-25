//
//  URLSessionCallable.swift
//  BoxOffice
//
//  Created by john-lim on 2023/01/19.
//

import Foundation

protocol URLSessionCallable {
    func startLoading(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
    func stopLoading()
}
