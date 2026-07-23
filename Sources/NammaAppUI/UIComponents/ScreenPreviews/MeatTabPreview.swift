//
//  MeatTabView.swift
//  NammaAppUI
//
//  Created by apple on 22/07/26.
//

import SwiftUI

struct MeatTabPreview: View {
    @State
    private var appTheme = AppThemeManager.shared
    
    var body: some View {
        List {
            NAStaggeredGridViewV1()
            NASpotlightInRowViewV1()
            ReusableHeaderView(style: .highlighted(title: "From your near by shops", subtitle: "Top picks for you"))
            ForEach(0..<4) { item in
                NAShopCardViewV1() {
                    
                }
            }
            ReusableHeaderView(style: .highlighted(title: "From your near by shops", subtitle: "Top picks for you"))
            NASpotlightInRowViewV1()
            ReusableHeaderView(style: .highlighted(title: "From your near by shops", subtitle: "Top picks for you"))
            ForEach(0..<3) { item in
                NAShopCardViewV1() {
                    
                }
            }
            NASpotlightInRowViewV2()
        }
        .listStyle(.plain)
        .listRowSpacing(0)
    }
}

// MARK: - Preview Setup Engine
#Preview {
    MeatTabPreview()
}
