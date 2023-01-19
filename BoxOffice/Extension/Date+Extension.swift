//
//  Date+Extension.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import Foundation

extension Date {
    func convertToLiteral() -> String {
        return DateFormatter.yearMonthDay.string(from: self)
    }
}
