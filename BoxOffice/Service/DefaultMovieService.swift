//
//  DefaultMovieService.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import Foundation

final class DefaultMovieService: MovieService {
    let networkProvider: NetworkProvider = DefaultNetworkProvider()
}
