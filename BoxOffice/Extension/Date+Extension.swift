//
//  Date+Extension.swift
//  BoxOffice
//
//  Created by kakao on 2023/02/02.
//

import Foundation

extension Date {
    static var yesterday: Date {
        return Date() - 24 * 3600
    }
}
