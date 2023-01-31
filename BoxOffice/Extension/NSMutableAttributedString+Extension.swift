//
//  NSMutableAttributedString+Extension.swift
//  Expo1900
//
//  Created by john-lim on 2023/01/10.
//

import UIKit

extension NSMutableAttributedString {    
    func applyColor(_ color: UIColor) -> NSMutableAttributedString {
        self.addAttribute(.foregroundColor,
                          value: color,
                          range: NSRange(location: 0, length: self.string.count))
        return self
    }
}
