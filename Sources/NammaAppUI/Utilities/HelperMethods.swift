//
//  HelperMethods.swift
//  NammaAppUI
//
//  Created by apple on 19/07/26.
//

import SwiftUI

// MARK: - Multiline custom string
func attributedString(for title: String) -> AttributedString {
    var attributed = AttributedString(title)
    if let rangeOfNewline = title.range(of: "\n") {
        let topSubstring = title[..<rangeOfNewline.lowerBound]
        let dealsSubstring = title[rangeOfNewline.upperBound...]
        
        if let topRange = attributed.range(of: topSubstring) {
            attributed[topRange].font = .system(size: 28, weight: .black, design: .rounded)
        }
        
        if let dealsRange = attributed.range(of: dealsSubstring) {
            attributed[dealsRange].font = .system(size: 16, weight: .heavy, design: .rounded)
        }
    } else {
        attributed.font = .system(size: 24, weight: .black, design: .rounded)
    }
    return attributed
}
