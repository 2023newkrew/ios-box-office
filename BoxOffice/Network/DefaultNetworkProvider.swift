//
//  DefaultNetworkProvider.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import Foundation

final class DefaultNetworkProvider: NetworkProvider {
    let session: URLSessionable = URLSession.shared
    let decoder: DecodingUtility = JSONDecodingUtility()
}
