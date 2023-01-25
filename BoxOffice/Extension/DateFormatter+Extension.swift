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
        dateFormatter.dateFormat = "yyyymmdd"
        return dateFormatter
    }()
}
