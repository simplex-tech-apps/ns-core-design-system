//
//  FishTabView.swift
//  NammaAppUI
//
//  Created by apple on 22/07/26.
//

import SwiftUI

struct FishTabView: View {
    @State
    private var appTheme = AppThemeManager.shared
    
    var body: some View {
        List {
            ReusableHeaderView(style: .standard(title: "Shop by category", subtitle: nil))
            NAVerticalGrid_NxN_V2()
            ReusableHeaderView(style: .standard(title: "From Marine/Sea", subtitle: nil))
            NAHorizontalGrid_NxN_V2()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "From Freshwater/Lake", subtitle: nil))
            NAHorizontalGrid_NxN_V2()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Crab", subtitle: nil))
            NAHorizontalGrid_NxN_V2()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Prawns/Shell Fish", subtitle: nil))
            NAHorizontalGrid_NxN_V2()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Exotic", subtitle: nil))
            NAHorizontalGrid_NxN_V2()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Boneless", subtitle: nil))
            NAHorizontalGrid_NxN_V2()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Steaks", subtitle: nil))
            NAHorizontalGrid_NxN_V2()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Dry Fish", subtitle: nil))
            NAHorizontalGrid_NxN_V2()
            SeeAllButtonViewV2() {
                
            }
            ReusableHeaderView(style: .standard(title: "Freshly Frozen", subtitle: nil))
            NAHorizontalGrid_NxN_V2()
            SeeAllButtonViewV2() {
                
            }
        }
        .listStyle(.plain)
        .listRowSpacing(0)
    }
}

// MARK: - Preview Setup Engine
#Preview {
    FishTabView()
}
