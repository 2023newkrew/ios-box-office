//
//  MovieDetailSummary.swift
//  BoxOffice
//
//  Created by john-lim on 2023/02/02.
//

import Foundation

struct MovieDetailSummary {
    enum KeyType {
        case title
        case director
        case productYear
        case openYear
        case showTime
        case watchGrade
        case productNation
        case genre
        case actor
    }
    
    private let title: String
    private let director: String
    private let productYear: String
    private let openYear: String
    private let showTime: String
    private let watchGrade: String
    private let productNation: String
    private let genre: String
    private let actor: String
    
    init(title: String, director: String,
         productYear: String,
         openYear: String,
         showTime: String,
         watchGrade: String,
         productNation: String,
         genre: String,
         actor: String) {
        self.title = title
        self.director = director
        self.productYear = productYear
        self.openYear = openYear
        self.showTime = showTime
        self.watchGrade = watchGrade
        self.productNation = productNation
        self.genre = genre
        self.actor = actor
    }

    func key(of key: KeyType) -> String {
        switch key {
        case .title:
            return "제목"
        case .director:
            return "감독"
        case .productYear:
            return "제작년도"
        case .openYear:
            return "개봉일"
        case .showTime:
            return "상영시간"
        case .watchGrade:
            return "관람등급"
        case .productNation:
            return "제작국가"
        case .genre:
            return "장르"
        case .actor:
            return "배우"
        }
    }
    
    func value(of key: KeyType) -> String {
        switch key {
        case .title:
            return title
        case .director:
            return director
        case .productYear:
            return productYear
        case .openYear:
            return openYear
        case .showTime:
            return showTime
        case .watchGrade:
            return watchGrade
        case .productNation:
            return productNation
        case .genre:
            return genre
        case .actor:
            return actor
        }
    }
}
