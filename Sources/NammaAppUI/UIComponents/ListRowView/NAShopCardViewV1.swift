//
//  NAShopRowView.swift
//  NammaAppUI
//
//  Created by apple on 21/07/26.
//

import SwiftUI
import Kingfisher

// MARK: - Models
struct NAShopCardViewV1Model: Equatable, Identifiable, Hashable {
    let id: UUID
    let widgetType: [String]
    let name: String
    let shopCategoryCodes: [String]
    let shopCode: String
    let isNammaShop: Bool
    let imageURLs: [String]
}

// MARK: - Shops Card View
struct NAShopCardViewV1: View {
    let onTap: () -> Void
    
    let shop: NAShopCardViewV1Model = NAShopCardViewV1Model(
        id: UUID(),
        widgetType: ["FEATURED_BANNER", "NEARBY_SHOP"],
        name: "Namma Meat Corner - T. Nagar",
        shopCategoryCodes: ["CAT_CHICKEN", "CAT_MUTTON", "CAT_EGGS"],
        shopCode: "SH_TNAGAR_001",
        isNammaShop: true,
        imageURLs: ["https://lh3.googleusercontent.com/d/1xJ3DkfHzN2DPLGiIkq9uXz2Fcn9TxgxM", "https://lh3.googleusercontent.com/d/1xJ3DkfHzN2DPLGiIkq9uXz2Fcn9TxgxM"]
    )
    
    @State
    private var appTheme = AppThemeManager.shared

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 6) {
                GeometryReader { geometry in
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemGray6))
                        if let imageURL = shop.imageURLs.first {
                            KFImage(URL(string: imageURL))
                                .resizable()
                                .scaledToFill()
                                .frame(
                                    width: geometry.size.width,
                                    height: geometry.size.height
                                )
                                .clipped()
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .frame(height: 220)
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(shop.name)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(appTheme.current.secondary)
                            .lineLimit(2)
                        HStack(spacing: 3) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 10))
                                .foregroundColor(Color(red: 16/255, green: 110/255, blue: 43/255))
                            Text(String(format: "%.1f", 4.6))
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.black)
                            Text("1.2k ratings")
                                .font(.system(size: 11))
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 2)
                    }
                    Spacer()
                    HStack(spacing: 4) {
                        Text("Shop now")
                            .font(.system(size: 11, weight: .regular))
                        Image(systemName: "chevron.right")
                            .font(.system(size: 10, weight: .regular))
                    }
                    .foregroundStyle(appTheme.current.secondary)
                    .padding(8)
                    .background(
                        appTheme.current.secondary.opacity(0.1)
                    )
                    .clipShape(Capsule())
                }
                .padding(12)
            }
            .padding(4)
            .background(Color.white)
            .addCardViewEffectV2()
        }
        .buttonStyle(CardPressButtonStyle())
        .listRowInsets(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        .listRowSeparator(.hidden)
    }
}

// MARK: - Preview Setup Engine
#Preview {
    NAShopCardViewV1() {
        
    }
}
