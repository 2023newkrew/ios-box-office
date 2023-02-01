//
//  DateString.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import Foundation

enum Day {
    case today
    case yesterday
    
    var date: Date {
        switch self {
        case .today:
            return Date()
        case .yesterday:
            return Date(timeIntervalSinceNow: -86400)
        }
    }
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        switch self {
        case .today:
            formatter.dateFormat = "yyyy-MM-dd"
        case .yesterday:
            formatter.dateFormat = "yyyyMMdd"
        }
        return formatter
    }
    var formattedDate: String {
        return dateFormatter.string(from: date)
    }
}
