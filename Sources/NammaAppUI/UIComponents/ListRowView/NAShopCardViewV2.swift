//
//  NAShopRowView.swift
//  NammaAppUI
//
//  Created by apple on 21/07/26.
//

import SwiftUI
import Kingfisher

// MARK: - Models
struct NAShopCardViewV2Model: Equatable, Identifiable, Hashable {
    let id = UUID()
    let imageName: String
    let discountText: String
    let deliveryTime: String
    let isBolt: Bool
    let boltSubtitle: String
    let tagBadgeText: String?
    let isVeg: Bool
    let shopName: String
    let rating: Double
    let ratingCountText: String
    let location: String
    let distance: String
    let cuisines: String
    let costForTwo: String
    var isFavorite: Bool = false
    var isAd: Bool = false
}

// MARK: - Shops Card View
struct NAShopCardViewV2: View {
    let shop: NAShopCardViewV2Model
    let onTap: () -> Void
        
    private let ratingGreen = Color(red: 16/255, green: 130/255, blue: 60/255)
    private let boltOrange = Color(red: 245/255, green: 100/255, blue: 20/255)
    private let vegGreen = Color(red: 0/255, green: 140/255, blue: 70/255)
        
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .bottom) {
                    KFImage(URL(string: "https://lh3.googleusercontent.com/d/1xJ3DkfHzN2DPLGiIkq9uXz2Fcn9TxgxM"))
                        .resizable()
                        .scaledToFill()
                        .frame(height: 190)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        
                    VStack {
                        HStack(spacing: 8) {
                            if shop.isAd {
                                Text("Ad")
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundColor(.white.opacity(0.8))
                            }
                                
                            Spacer()

                            Button(action: {}) {
                                Image(
                                    systemName: shop.isFavorite ? "heart.fill" : "heart"
                                )
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(shop.isFavorite ? .red : .white)
                                .shadow(color: .black.opacity(0.4), radius: 3)
                            }
                            .buttonStyle(.plain)

                            Button(action: {}) {
                                Image(systemName: "ellipsis")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                                    .rotationEffect(.degrees(90))
                                    .shadow(color: .black.opacity(0.4), radius: 3)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.horizontal, 14)
                        .padding(.top, 12)
                            
                        Spacer()
                    }
                        
                    LinearGradient(
                        colors: [Color.black.opacity(0.6), Color.clear],
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .frame(height: 60)
                        
                    HStack(alignment: .bottom) {
                        HStack(spacing: 4) {
                            Image(systemName: "percent")
                                .font(.system(size: 9, weight: .black))
                                .padding(3)
                                .background(boltOrange)
                                .clipShape(Circle())
                                .foregroundColor(.white)
                                
                            Text(shop.discountText)
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 12)
                        .padding(.bottom, 8)
                            
                        Spacer()
                            
                        Text(shop.deliveryTime)
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(
                                Color(red: 30/255, green: 35/255, blue: 45/255)
                            )
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.white)
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 6,
                                    style: .continuous
                                )
                            )
                            .padding(.trailing, 10)
                            .padding(.bottom, 6)
                    }
                }
                .frame(height: 190)
                .clipShape(UnevenRoundedRectangle(
                    topLeadingRadius: 20,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 20
                ))
                    
                VStack(alignment: .leading, spacing: 5) {
                    HStack(spacing: 4) {
                        if shop.isBolt {
                            HStack(spacing: 2) {
                                Text("Bolt")
                                    .font(
                                        .system(
                                            size: 14,
                                            weight: .black,
                                            design: .rounded
                                        )
                                    )
                                    .foregroundColor(
                                        Color(
                                            red: 30/255,
                                            green: 35/255,
                                            blue: 45/255
                                        )
                                    )
                                    
                                Image(systemName: "bolt.fill")
                                    .font(.system(size: 11))
                                    .foregroundColor(boltOrange)
                            }
                        }
                            
                        Text(shop.boltSubtitle)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(
                                Color(red: 50/255, green: 55/255, blue: 65/255)
                            )
                            
                        if let tagText = shop.tagBadgeText {
                            HStack(spacing: 3) {
                                if shop.isVeg {
                                    Image(systemName: "leaf.fill")
                                        .font(.system(size: 10))
                                        .foregroundColor(vegGreen)
                                } else {
                                    Text("🎂")
                                        .font(.system(size: 10))
                                }
                                    
                                Text(tagText)
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(
                                        shop.isVeg ? vegGreen : Color(
                                            red: 60/255,
                                            green: 65/255,
                                            blue: 75/255
                                        )
                                    )
                            }
                            .padding(.leading, 2)
                        }
                    }
                    .padding(.top, 8)
                        
                    Text(shop.shopName)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(
                            Color(red: 20/255, green: 25/255, blue: 35/255)
                        )
                        .lineLimit(2)
                        
                    HStack(spacing: 4) {
                        Image(systemName: "star.circle.fill")
                            .font(.system(size: 15))
                            .foregroundColor(ratingGreen)
                            
                        Text(String(format: "%.1f", shop.rating))
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(
                                Color(red: 40/255, green: 45/255, blue: 55/255)
                            )
                            
                        Text("(\(shop.ratingCountText))")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.secondary)
                            
                        Text("•")
                            .foregroundColor(.secondary)
                            
                        Text("\(shop.location), \(shop.distance)")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.secondary)
                    }
                        
                    HStack(spacing: 4) {
                        Text(shop.cuisines)
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.secondary)
                            
                        Text("•")
                            .foregroundColor(.secondary)
                            
                        Text(shop.costForTwo)
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 14)
                .background(Color.white)
                .clipShape(UnevenRoundedRectangle(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 20,
                    bottomTrailingRadius: 20,
                    topTrailingRadius: 0
                ))
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .addCardViewEffectV2()
        }
        .buttonStyle(CardPressButtonStyle())
        .listRowInsets(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        .listRowSeparator(.hidden)
    }
}

// MARK: - Preview Setup Engine
#Preview {
    let shop = NAShopCardViewV2Model(
        imageName: "paneer_thali",
        discountText: "70% off upto ₹130",
        deliveryTime: "25-30 MINS",
        isBolt: true,
        boltSubtitle: "Food in 10-15 min",
        tagBadgeText: "Pure Veg",
        isVeg: true,
        shopName: "ITC Aashirvaad Soul Creations",
        rating: 4.3,
        ratingCountText: "3.3K+",
        location: "Ramapuram",
        distance: "1.3 km",
        cuisines: "Indian, pure veg",
        costForTwo: "₹500 for two",
        isAd: true
    )
    
    NAShopCardViewV2(shop: shop) {
        
    }
}
