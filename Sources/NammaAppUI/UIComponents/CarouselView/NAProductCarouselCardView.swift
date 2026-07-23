//
//  NAProductCarouselCard.swift
//  NammaAppUI
//
//  Created by apple on 19/07/26.
//

import SwiftUI

// MARK: - Individual Component Layout Card
struct NAProductCarouselCardView: View {
    let product: ProductCarouselModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .bottom) {
                Color(red: 16/255, green: 110/255, blue: 43/255)
                Image("chicken_product", bundle: .module)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 240)
                    .clipped()
                HStack(alignment: .bottom) {
                    Text("1 kg")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.primary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.white)
                        .cornerRadius(6)
                        .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray.opacity(0.2), lineWidth: 0.8))
                        .padding(.leading, 8)
                        .padding(.bottom, 8)
                    
                    Spacer()
                    
                    ZStack {
                        if product.quantity > 0 {
                            HStack(spacing: 0) {
                                Button(action: {  }) {
                                    Image(systemName: "plus").font(.system(size: 10, weight: .bold))
                                }
                                .frame(height: 16)
                                .padding(.leading, 8)
                                Spacer()
                                Text("\(product.quantity)")
                                    .font(.system(size: 12, weight: .bold))
                                    .frame(height: 14)
                                Spacer()
                                Button(action: {  }) {
                                    Image(systemName: "minus").font(.system(size: 10, weight: .bold))
                                }
                                .frame(height: 16)
                                .padding(.trailing, 8)
                            }
                            .foregroundColor(.white)
                            .frame(width:60, height: 34)
                            .background(Color(red: 45/255, green: 115/255, blue: 55/255))
                            .cornerRadius(8)
                        } else {
                            Button(action: { }) {
                                VStack(spacing: 1) {
                                    Text("ADD")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(Color(red: 45/255, green: 115/255, blue: 55/255))
                                    
                                    if product.hasOptions {
                                        Text("2 options")
                                            .font(.system(size: 7))
                                            .foregroundColor(.gray)
                                    }
                                }
                                .frame(width: 44, height: 34)
                                .background(Color.white, in: RoundedRectangle(cornerRadius: 8))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(red: 45/255, green: 115/255, blue: 55/255), lineWidth: 1)
                                )
                            }
                        }
                    }
                    .padding(.trailing, 8)
                    .padding(.bottom, 8)
                }
            }
            .frame(height: 240)
            .clipShape(UnevenRoundedRectangle(topLeadingRadius: 32, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 32, style: .continuous))
            
            ZStack(alignment: .center) {
                Color.white
                VStack(alignment: .leading, spacing: 5) {
                    HStack(alignment: .center, spacing: 6) {
                        Text("₹\(product.currentPrice)")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(Color(red: 16/255, green: 110/255, blue: 43/255))
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                        
                        Text("₹\(product.originalPrice)")
                            .font(.system(size: 13))
                            .foregroundColor(.secondary)
                            .strikethrough()
                        Spacer()
                        HStack(spacing: 3) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 10))
                                .foregroundColor(Color(red: 16/255, green: 110/255, blue: 43/255))
                            Text(String(format: "%.1f", product.rating))
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.black)
                            Text(product.ratingCountText)
                                .font(.system(size: 11))
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 2)
                    }
                    
                    Text(product.discountText)
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(red: 16/255, green: 110/255, blue: 43/255))
                    
                    Text(product.title)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.black.opacity(0.85))
                    
                    if let promo = product.promotionText {
                        Button(action: {}) {
                            HStack(spacing: 3) {
                                Text(promo)
                                    .font(.system(size: 11, weight: .bold))
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 8, weight: .bold))
                            }
                            .foregroundColor(.blue)
                            .padding(.top, 2)
                            .overlay(
                                LineStylePattern()
                                    .stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .miter, dash: [1, 2]))
                                    .foregroundColor(.blue)
                                    .frame(height: 1)
                                    .padding(.top, 16)
                            )
                        }
                    }
                }
                .padding(.horizontal, 12)
            }
            .frame(height: 120)
            .clipShape(UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 32, bottomTrailingRadius: 32, topTrailingRadius: 0, style: .continuous))
        }
        .frame(width: 320)
        .background(Color.clear)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Preview Setup Engine
#Preview {
    let product = ProductCarouselModel(
        title: "Premium Tender Chicken Curry Cut",
        volumeInfo: "500g",
        finishTag: "Freshly Cut",
        currentPrice: 179,
        originalPrice: 220,
        discountText: "18% OFF",
        rating: 4.8,
        ratingCountText: "1.2k ratings",
        productImage: "fresh_chicken_curry",
        isFavorite: false,
        quantity: 0,
        hasOptions: false,
        promotionText: "Buy 1/2 kg, get 1 egg FREE!"
    )
    NAProductCarouselCardView(product: product)
}
