//
//  NSMutableAttributedString+Extension.swift
//  Expo1900
//
//  Created by john-lim on 2023/01/10.
//

import UIKit

extension NSMutableAttributedString {
    func applyFont(_ font: UIFont) -> NSMutableAttributedString {
        let range = NSRange(location: 0, length: self.string.count)
        self.addAttribute(.font,
                          value: font,
                          range: range)
        return self
    }
    
    func applyPreferredFont(_ font: UIFont.TextStyle) -> NSMutableAttributedString {
        let range = NSRange(location: 0, length: self.string.count)
        self.addAttribute(.font,
                          value: UIFont.preferredFont(forTextStyle: font),
                          range: range)
        return self
    }
    
    func applyColor(_ color: UIColor) -> NSMutableAttributedString {
        self.addAttribute(.foregroundColor,
                          value: color,
                          range: NSRange(location: 0, length: self.string.count))
        return self
    }
}
