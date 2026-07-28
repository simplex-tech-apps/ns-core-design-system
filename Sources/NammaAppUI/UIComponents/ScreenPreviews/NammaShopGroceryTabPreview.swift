//
//  NammaShopAllTabPreview.swift
//  NammaAppUI
//
//  Created by apple on 28/07/26.
//

import SwiftUI

struct NammaShopGroceryTabPreview: View {
    @State
    private var appTheme = AppThemeManager.shared
    
    var body: some View {
        List {
            Image("fresh_grocery", bundle: .module)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, minHeight: 150, maxHeight: 200)
                .clipped()
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            NAHorizontalGrid_NxN_V3()
                .padding(.top, 8)
            ReusableHeaderView(style: .standard(title: "Daily Essentials"))
            NAHorizontalGrid_NxN_V4(columnCount: 4, rowCount: 1)
            ReusableHeaderView(style: .standard(title: "Snacks and Drinks"))
            NAHorizontalGrid_NxN_V4(columnCount: 4, rowCount: 1)
            ReusableHeaderView(style: .standard(title: "Home Needs"))
            NAHorizontalGrid_NxN_V4(columnCount: 4, rowCount: 3)
            ReusableHeaderView(style: .standard(title: "Clearence sale"))
            NAHorizontalGrid_NxN_V3(rowCount: 3, columnCount: 3, scrollDirection: .vertical)
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Fresh picks, just in!"))
            NAHorizontalGrid_NxN_V3(rowCount: 3, columnCount: 3, scrollDirection: .vertical)
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Tea & Coffee"))
            NAHorizontalGrid_NxN_V3(rowCount: 3, columnCount: 3, scrollDirection: .vertical)
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Dal Staples"))
            NAHorizontalGrid_NxN_V3(rowCount: 3, columnCount: 3, scrollDirection: .vertical)
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Instant food"))
            NAHorizontalGrid_NxN_V3(rowCount: 3, columnCount: 3, scrollDirection: .vertical)
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Indian Sweets"))
            NAHorizontalGrid_NxN_V3(rowCount: 3, columnCount: 3, scrollDirection: .vertical)
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Snacks & Munchies"))
            NAHorizontalGrid_NxN_V3(rowCount: 3, columnCount: 3, scrollDirection: .vertical)
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Cleaning essentials"))
            NAHorizontalGrid_NxN_V3(rowCount: 1, columnCount: 3, scrollDirection: .vertical)
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Wholesome Dals"))
            NAHorizontalGrid_NxN_V3(rowCount: 1, columnCount: 3, scrollDirection: .vertical)
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Stay fresh and hydrated"))
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
    NammaShopGroceryTabPreview()
}
