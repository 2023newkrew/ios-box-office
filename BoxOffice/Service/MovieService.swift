//
//  MovieService.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import Foundation

protocol MovieService {
    var networkProvider: NetworkProvider { get }
    
    @discardableResult
    func fetchBoxoffice(
        date: Date,
        itemPerPage: Int?,
        movieType: MovieType?,
        nationType: NationType?,
        areaCode: String?,
        completion: @escaping ((Result<Boxoffice, NetworkError>) -> Void)
    ) -> Cancellable?
    
    @discardableResult
    func fetchMovieInformation(
        for movieCode: String,
        completion: @escaping ((Result<Movie, NetworkError>) -> Void)
    ) -> Cancellable?
}

extension MovieService {
    func fetchBoxoffice(
        date: Date,
        itemPerPage: Int? = nil,
        movieType: MovieType? = nil,
        nationType: NationType? = nil,
        areaCode: String? = nil,
        completion: @escaping ((Result<Boxoffice, NetworkError>) -> Void)
    ) -> Cancellable? {
        let endpoint = BoxofficeEndpoint(
            date: date,
            itemPerPage: itemPerPage,
            movieType: movieType,
            nationType: nationType,
            areaCode: areaCode
        )
        return self.networkProvider.request(endpoint) { result in
            completion(result.map { $0.toModel(for: date) })
        }
    }
    
    func fetchMovieInformation(
        for movieCode: String,
        completion: @escaping ((Result<Movie, NetworkError>) -> Void)
    ) -> Cancellable? {
        let endpoint = MovieInformationEndpoint(movieCode: movieCode)
        
        return self.networkProvider.request(endpoint) { result in
            completion(result.map { $0.movieInformationResult.movieInformation.toModel() })
        }
    }
}

