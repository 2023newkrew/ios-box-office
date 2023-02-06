//
//  DateFormatter+Extension.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import Foundation

extension DateFormatter {
    static let yearMonthDay: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter
    }()
    
    static let yearMonthDayWithDash: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
}
