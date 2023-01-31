//
//  String+Extention.swift
//  BoxOffice
//
//  Created by john-lim on 2023/01/30.
//

import Foundation

extension String {
    func decimalFormat() -> String {
        guard let number = Int(self) else {
            return self
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: number)) ?? self
    }
}
