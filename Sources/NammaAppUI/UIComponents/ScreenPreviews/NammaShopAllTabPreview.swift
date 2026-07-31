//
//  NammaShopAllTabPreview.swift
//  NammaAppUI
//
//  Created by apple on 28/07/26.
//

import SwiftUI

struct NammaShopAllTabPreview: View {
    @State
    private var appTheme = AppThemeManager.shared
    
    var body: some View {
        List {
            Image("namma_shop", bundle: .module)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, minHeight: 150, maxHeight: 200)
                .clipped()
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            NAHorizontalGrid_NxN_V3()
                .padding(.top, 8)
            ReusableHeaderView(style: .standard(title: "Fresh items"))
            NAHorizontalGrid_NxN_V4(columnCount: 4, rowCount: 1)
            ReusableHeaderView(style: .standard(title: "Grocery & Kitchen"))
            NAHorizontalGrid_NxN_V4(columnCount: 4, rowCount: 1)
            ReusableHeaderView(style: .standard(title: "Snacks & drinks"))
            NAHorizontalGrid_NxN_V4(columnCount: 4, rowCount: 3)
            ReusableHeaderView(style: .standard(title: "Beauty & Wellness"))
            NAHorizontalGrid_NxN_V4(columnCount: 4, rowCount: 2)
            ReusableHeaderView(style: .standard(title: "Household & Lifestyle"))
            NAHorizontalGrid_NxN_V4(columnCount: 4, rowCount: 1)
            ReusableHeaderView(style: .standard(title: "Baby Care Essentials"))
            NAHorizontalGrid_NxN_V3(rowCount: 3, columnCount: 3, scrollDirection: .vertical)
            SeeAllButtonViewV2() {
                
            }
            NACarouselViewV2().padding(.top, 12)
            ReusableHeaderView(style: .standard(title: "Discover Your Favorite Scoop"))
            NAHorizontalGrid_NxN_V3(rowCount: 3, columnCount: 3, scrollDirection: .vertical)
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Treding today"))
            NACarouselViewV2()
            ReusableHeaderView(style: .standard(title: "Best deals on cooking essentials"))
            NAHorizontalGrid_NxN_V3(rowCount: 3, columnCount: 3, scrollDirection: .vertical)
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Best deals on baby care"))
            NAHorizontalGrid_NxN_V3(rowCount: 3, columnCount: 3, scrollDirection: .vertical)
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Pet supplies upto 50% off"))
            NAHorizontalGrid_NxN_V3(rowCount: 3, columnCount: 3, scrollDirection: .vertical)
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Refreshing cold sips"))
            NAHorizontalGrid_NxN_V3(rowCount: 3, columnCount: 3, scrollDirection: .vertical)
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Best in skincare"))
            NAHorizontalGrid_NxN_V3(rowCount: 3, columnCount: 3, scrollDirection: .vertical)
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Regional pantry picks"))
            NAHorizontalGrid_NxN_V3(rowCount: 1, columnCount: 3, scrollDirection: .vertical)
            SeeAllButtonViewV2() {
                
            }
        }
        .listStyle(.plain)
        .listRowSpacing(0)
    }
}

// MARK: - Preview Setup Engine
#Preview {
    NammaShopAllTabPreview()
}
