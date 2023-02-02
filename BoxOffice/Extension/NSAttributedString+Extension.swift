//
//  NSAttributedString+Extension.swift
//  Expo1900
//
//  Created by john-lim on 2023/01/10.
//

import UIKit

extension NSAttributedString {
    static func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
        let mutableString = NSMutableAttributedString()
        mutableString.append(lhs)
        mutableString.append(rhs)
        return mutableString
    }
}

