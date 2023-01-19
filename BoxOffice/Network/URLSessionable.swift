//
//  URLSessionable.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import Foundation

protocol URLSessionable {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
}
