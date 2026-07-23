//
//  FreshTab.swift
//  NammaAppUI
//
//  Created by apple on 21/07/26.
//

import SwiftUI

struct FreshTabView: View {
    @State
    private var appTheme = AppThemeManager.shared
    
    var body: some View {
        List {
            ReusableHeaderView(style: .standard(title: "Shop by category"))
            NAVerticalGrid_NxN_V1()
            NASpotlightInRowViewV2()
            ReusableHeaderView(style: .standard(title: "Top deals on bestsellers"))
            NAHorizontalGrid_NxN_V1()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Fresh Seasonal Delights"))
            NAHorizontalGrid_NxN_V1()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Breads and Buns"))
            NAHorizontalGrid_NxN_V1()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Daily Eggs upto 40% off"))
            NAHorizontalGrid_NxN_V1()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Cheese and Butter"))
            NAHorizontalGrid_NxN_V1()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Paneer & More!"))
            NAHorizontalGrid_NxN_V1()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Mango Mania"))
            NAHorizontalGrid_NxN_V1()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Summer Veggies"))
            NAHorizontalGrid_NxN_V1()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Yoghurts and Milkshakes"))
            NAHorizontalGrid_NxN_V1()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Batters & More!"))
            NAHorizontalGrid_NxN_V1()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Freshly made in small batches"))
            NAHorizontalGrid_NxN_V1()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Fresh Lassi, Smoothies & More!"))
            NAHorizontalGrid_NxN_V1()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Fresh chicken & seafood at best prices"))
            NAHorizontalGrid_NxN_V1()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Season's Special"))
            NAHorizontalGrid_NxN_V1()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Fresh organics"))
            NAHorizontalGrid_NxN_V1()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Curds"))
            NAHorizontalGrid_NxN_V1()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Almond Milk and Others"))
            NAHorizontalGrid_NxN_V1()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Fresh Salad Needs"))
            NAHorizontalGrid_NxN_V1()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Indian Breads"))
            NAHorizontalGrid_NxN_V1()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Plants for Your Garden"))
            NAHorizontalGrid_NxN_V1()
            SeeAllButtonViewV2() {
                
            }
        }
        .listStyle(.plain)
        .listRowSpacing(0)
    }
}

// MARK: - Preview Setup Engine
#Preview {
    FreshTabView()
}
