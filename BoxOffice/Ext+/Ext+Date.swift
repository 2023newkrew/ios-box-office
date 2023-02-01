//
//  Ext+Date.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import Foundation

extension Date {
    enum Days {
        case today
        case yesterday
    }
    
    enum DayFormat: String {
        case yyyyMMdd = "yyyyMMdd"
        case yyyy_MM_dd = "yyyy-MM-dd"
    }
    
    static func dayString(_ day: Days, format: DayFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        switch day {
        case .today:
            return formatter.string(from: Self())
        case .yesterday:
            return formatter.string(from: Self() - 86400)
        }
    }
}
