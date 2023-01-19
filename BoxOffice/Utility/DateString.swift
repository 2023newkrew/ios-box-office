//
//  DateString.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import Foundation

enum DateString {
    case today
    case yesterday
    
    var date: Date {
        switch self {
        case .today:
            if #available(iOS 15, *) {
                return Date.now
            } else {
                return Date()
            }
        case .yesterday:
            if #available(iOS 15, *) {
                return Calendar.current.date(byAdding: .day, value: -1, to: Date.now) ?? Date()
            } else {
                return Date()
            }
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
    var value: String {
        return dateFormatter.string(from: date)
    }
}
