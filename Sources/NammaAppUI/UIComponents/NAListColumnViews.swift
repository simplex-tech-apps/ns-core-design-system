//
//  NAListColumnViews.swift
//  NammaAppUI
//
//  Created by apple on 18/03/26.
//

import SwiftUI
import Kingfisher

struct NAListColumnViews: View {
    @State
    private var appTheme = AppThemeManager.shared
    
    var body: some View {
        ZStack {
            appTheme.current.background.ignoresSafeArea()
            List {
                VStack(spacing: 20) {
                    
                }.listRowSeparator(.hidden).listRowBackground(appTheme.current.background)
            }.listStyle(.plain)
        }
    }
}

public struct ShopCategoryColumn: View {
    @State
    private var appTheme = AppThemeManager.shared
    
    //MARK: Stored Properties
    var shopCategoryURL: String
    var title: String
    var isSelected: Bool
    var onClick: () -> Void
    
    public init(shopCategoryURL: String, title: String, isSelected: Bool, onClick: @escaping () -> Void) {
        self.shopCategoryURL = shopCategoryURL
        self.title = title
        self.isSelected = isSelected
        self.onClick = onClick
    }
    
    public var body: some View {
        Button(action: {
            onClick()
        }) {
            VStack {
                ZStack {
                    KFImage(URL(string: shopCategoryURL))
                        .resizable()
                        .frame(width: 50, height: 50)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                }
                .frame(width: 75, height: 75).addCardViewEffectV1()
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isSelected ? appTheme.current.primary : Color.clear, lineWidth: 2)
                )
                .overlay(
                    Group {
                        if isSelected {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundColor(appTheme.current.primary)
                                .background(Circle().fill(appTheme.current.onPrimary))
                                .padding(4)
                        }
                    },
                    alignment: .topLeading
                )
                Text(title).font(.system(size: 10, weight: .medium)).foregroundStyle(appTheme.current.secondary)
            }.fixedSize()
        }.buttonStyle(ScaledButtonStyle())
    }
}
