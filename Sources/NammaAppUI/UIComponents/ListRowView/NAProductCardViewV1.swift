//
//  NAProductCardViewV1.swift
//  NammaAppUI
//
//  Created by apple on 21/07/26.
//

import SwiftUI

// MARK: - Individual Product Card View
struct NAProductCardViewV1: View {
    @Binding var product: ProductItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topTrailing) {
                Image("vegetables", bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 12)
                
                Button(action: { product.isFavorite.toggle() }) {
                    Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                        .font(.system(size: 18))
                        .foregroundColor(.pink)
                        .padding(8)
                }
                
                VStack {
                    Spacer()
                    Button(action: { }) {
                        Text("ADD")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.pink)
                            .frame(width: 65, height: 32)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.white)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .strokeBorder(Color.pink, lineWidth: 1.5)
                            )
                            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
                    }
                    .padding(.bottom, -8)
                    .padding(.trailing, 8)
                }
            }
            .frame(height: 130)
            
            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .center, spacing: 6) {
                    Text("₹\(product.currentPrice)")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 4)
                        .background(Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    
                    Text("₹\(product.originalPrice)")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                        .strikethrough()
                }
                .padding(.top, 14)
                
                Text(product.discountText)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.green)
                
                Text(product.title)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.primary)
                    .lineLimit(3)
                    .frame(height: 54, alignment: .topLeading)
                
                Text(product.weightInfo)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                
                Text(product.flavourTag)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(Color(red: 20/255, green: 90/255, blue: 110/255))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(red: 230/255, green: 245/255, blue: 248/255))
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                
                HStack(spacing: 3) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 10))
                        .foregroundColor(.green)
                    Text(String(format: "%.1f", product.rating))
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.primary)
                    Text(product.ratingCountText)
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                }
                .padding(.top, 2)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 12)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - Preview Setup Engine
#Preview {
    @Previewable @State var product = ProductItem(title: "Lay's American Cream & Onion Flavour | Potato Chips", weightInfo: "1 pack (80 g)", flavourTag: "Cream & Onion", currentPrice: 38, originalPrice: 48, discountText: "₹10 OFF", rating: 4.7, ratingCountText: "(52k)", productImage: "lays_green")
    NAProductCardViewV1(product: $product)
        .frame(width: 165)
}
