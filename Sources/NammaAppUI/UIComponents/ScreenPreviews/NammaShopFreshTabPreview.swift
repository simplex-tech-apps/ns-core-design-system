//
//  NammaShopAllTabPreview.swift
//  NammaAppUI
//
//  Created by apple on 28/07/26.
//

import SwiftUI

struct NammaShopFreshTabPreview: View {
    @State
    private var appTheme = AppThemeManager.shared
    @State
    private var category: NammaShopFreshTabCategories = .vegetable
    
    var body: some View {
        List {
            Image("fresh_veg_fruits", bundle: .module)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, minHeight: 150, maxHeight: 200)
                .clipped()
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            NATabbarViewV2(selectedCategory: $category)
            NAHorizontalGrid_NxN_V3()
                .padding(.vertical, 12)
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Shop by category"))
            NAVerticalGrid_NxN_V1()
            ReusableHeaderView(style: .standard(title: "Mangoes & Melons"))
            NAHorizontalGrid_NxN_V3()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Low Prices on Exotics"))
            NAHorizontalGrid_NxN_V3()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Fresh Arrivals"))
            NAHorizontalGrid_NxN_V3()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Fresh Vegetables"))
            NAHorizontalGrid_NxN_V3()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Fresh Fruits"))
            NAHorizontalGrid_NxN_V3()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Leafy, Herbs & Seasonings"))
            NAHorizontalGrid_NxN_V3()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Exotics  & Premium"))
            NAHorizontalGrid_NxN_V3()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Plants & Flowers"))
            NAHorizontalGrid_NxN_V3()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Fresh from farm, at low prices"))
            NAHorizontalGrid_NxN_V3()
            SeeAllButtonViewV2() {
                
            }
        }
        .listStyle(.plain)
        .listRowSpacing(0)
    }
}

// MARK: - Preview Setup Engine
#Preview {
    NammaShopFreshTabPreview()
}
