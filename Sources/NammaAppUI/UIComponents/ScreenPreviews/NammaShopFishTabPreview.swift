//
//  NammaShopAllTabPreview.swift
//  NammaAppUI
//
//  Created by apple on 28/07/26.
//

import SwiftUI

struct NammaShopFishTabPreview: View {
    @State
    private var appTheme = AppThemeManager.shared
    
    var body: some View {
        List {
            Image("fresh_fish", bundle: .module)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, minHeight: 150, maxHeight: 200)
                .clipped()
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            NASpotlightInRowViewV3()
            ReusableHeaderView(style: .highlighted(title: "Express Delivery", subtitle: "Delivery for you in 60 mins"))
            NAHorizontalGrid_NxN_V3()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .highlighted(title: "Personalized Cuts", subtitle: "Choose how the cut to be as you wish"))
            NAHorizontalGrid_NxN_V3()
            SeeAllButtonViewV2() {
                
            }
            NAVerticalGrid_NxN_V3()
        }
        .listStyle(.plain)
        .listRowSpacing(0)
    }
}

// MARK: - Preview Setup Engine
#Preview {
    NammaShopFishTabPreview()
}
