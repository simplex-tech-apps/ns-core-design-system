//
//  NammaShopAllTabPreview.swift
//  NammaAppUI
//
//  Created by apple on 28/07/26.
//

import SwiftUI

struct NammaShopMeatTabPreview: View {
    @State
    private var appTheme = AppThemeManager.shared
    
    var body: some View {
        List {
            Image("fresh_meat", bundle: .module)
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
            ReusableHeaderView(style: .highlighted(title: "Mutton", subtitle: "Your favourite poultry is here"))
            NAVerticalGrid_NxN_V3()
            ReusableHeaderView(style: .highlighted(title: "Poultry", subtitle: "Your favourite poultry is here"))
            NAVerticalGrid_NxN_V3()
            ReusableHeaderView(style: .highlighted(title: "Fresh Eggs", subtitle: "Protein that you need daily"))
            NAHorizontalGrid_NxN_V3(rowCount: 0, columnCount: 3, scrollDirection: .vertical)
        }
        .listStyle(.plain)
        .listRowSpacing(0)
    }
}

// MARK: - Preview Setup Engine
#Preview {
    NammaShopMeatTabPreview()
}
