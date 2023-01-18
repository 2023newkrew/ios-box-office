//
//  Ext+Date.swift
//  BoxOffice
//
//  Created by kakao on 2023/01/19.
//

import Foundation

extension Date {
    static var today: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter.string(from: Self())
    }
}
