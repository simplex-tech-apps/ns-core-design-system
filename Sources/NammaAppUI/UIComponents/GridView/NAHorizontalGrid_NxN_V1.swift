//
//  NAHorizontalGrid_NxN_V1.swift
//  NammaAppUI
//
//  Created by apple on 22/07/26.
//

import SwiftUI

// MARK: - Vertical Grid Model
struct NAHorizontalGrid_NxN_V1Model: Identifiable {
    let id = UUID()
    let title: String
    let volumeInfo: String
    let finishTag: String
    let currentPrice: Int
    let originalPrice: Int
    let discountText: String
    let rating: Double
    let ratingCountText: String
    let productImage: String
    var isFavorite: Bool = false
    var quantity: Int = 0
    let hasOptions: Bool
    let promotionText: String? 
}

// MARK: - Main Grid View
public struct NAHorizontalGrid_NxN_V1: View {
    @State private var products = [
        NAHorizontalGrid_NxN_V1Model(
            title: "Blue Heaven Intense Matte Lipstick | Plum D...",
            volumeInfo: "1 pc (4 g)",
            finishTag: "Matte Finish",
            currentPrice: 94,
            originalPrice: 110,
            discountText: "₹16 OFF",
            rating: 3.9,
            ratingCountText: "(2k)",
            productImage: "vegetables",
            quantity: 1,
            hasOptions: false,
            promotionText: "Buy 1 Get 1 Free"
        ),
        NAHorizontalGrid_NxN_V1Model(
            title: "Lakme Forever Matte Liquid Lip, 16hr Lipstick, Lig...",
            volumeInfo: "5.6 ml",
            finishTag: "Matte Finish",
            currentPrice: 326,
            originalPrice: 450,
            discountText: "₹124 OFF",
            rating: 4.4,
            ratingCountText: "(1k)",
            productImage: "vegetables",
            quantity: 0,
            hasOptions: true,
            promotionText: nil
        ),
        NAHorizontalGrid_NxN_V1Model(
            title: "Insight Cosmetics Non Transfer Liquid Lipstick |...",
            volumeInfo: "1 pc (4 ml)",
            finishTag: "SPF 15",
            currentPrice: 121,
            originalPrice: 130,
            discountText: "₹9 OFF",
            rating: 4.1,
            ratingCountText: "(2k)",
            productImage: "vegetables",
            quantity: 0,
            hasOptions: true,
            promotionText: nil
        ),
        NAHorizontalGrid_NxN_V1Model(
            title: "Insight Cosmetics Non Transfer Liquid Lipstick |...",
            volumeInfo: "1 pc (4 ml)",
            finishTag: "SPF 15",
            currentPrice: 121,
            originalPrice: 130,
            discountText: "₹9 OFF",
            rating: 4.1,
            ratingCountText: "(2k)",
            productImage: "vegetables",
            quantity: 0,
            hasOptions: true,
            promotionText: nil
        ),
        NAHorizontalGrid_NxN_V1Model(
            title: "Insight Cosmetics Non Transfer Liquid Lipstick |...",
            volumeInfo: "1 pc (4 ml)",
            finishTag: "SPF 15",
            currentPrice: 121,
            originalPrice: 130,
            discountText: "₹9 OFF",
            rating: 4.1,
            ratingCountText: "(2k)",
            productImage: "vegetables",
            quantity: 0,
            hasOptions: true,
            promotionText: nil
        ),
        NAHorizontalGrid_NxN_V1Model(
            title: "Insight Cosmetics Non Transfer Liquid Lipstick |...",
            volumeInfo: "1 pc (4 ml)",
            finishTag: "SPF 15",
            currentPrice: 121,
            originalPrice: 130,
            discountText: "₹9 OFF",
            rating: 4.1,
            ratingCountText: "(2k)",
            productImage: "vegetables",
            quantity: 0,
            hasOptions: true,
            promotionText: nil
        ),
        NAHorizontalGrid_NxN_V1Model(
            title: "Insight Cosmetics Non Transfer Liquid Lipstick |...",
            volumeInfo: "1 pc (4 ml)",
            finishTag: "SPF 15",
            currentPrice: 121,
            originalPrice: 130,
            discountText: "₹9 OFF",
            rating: 4.1,
            ratingCountText: "(2k)",
            productImage: "vegetables",
            quantity: 0,
            hasOptions: true,
            promotionText: nil
        )
    ]
    
    private let gridRows: [GridItem] = [
        GridItem(.fixed(310), spacing: 16)
    ]
    
   public init() {}
    
   public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: gridRows, alignment: .top, spacing: 12) {
                ForEach($products) { $product in
                    NAHorizontalGrid_NxN_V1_CardView(product: $product)
                        .frame(width: 140)
                }
                
            }
            .padding(.horizontal, 12)
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
    }
}

// MARK: - Individual Category Card Component View
struct NAHorizontalGrid_NxN_V1_CardView: View {
    
    @Binding var product: NAHorizontalGrid_NxN_V1Model
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                Image(product.productImage, bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipped()
                
                VStack {
                    HStack {
                        Spacer()
                        Button(action: { product.isFavorite.toggle() }) {
                            Image(
                                systemName: product.isFavorite ? "heart.fill" : "heart"
                            )
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.pink)
                            .padding(8)
                            .background(Color.white.opacity(0.4))
                            .clipShape(Circle())
                        }
                        .padding([.top, .trailing], 8)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        if product.quantity > 0 {
                            HStack(spacing: 12) {
                                Button(action: { product.quantity -= 1 }) {
                                    Image(systemName: "minus")
                                        .font(.system(size: 12, weight: .bold))
                                }
        
                                Text("\(product.quantity)")
                                    .font(.system(size: 12, weight: .bold))
                                
                                Button(action: { product.quantity += 1 }) {
                                    Image(systemName: "plus")
                                        .font(.system(size: 12, weight: .bold))
                                }
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .frame(height: 32)
                            .background(
                                Color(red: 226/255, green: 18/255, blue: 73/255)
                            )
                            .cornerRadius(8)
                            .padding([.bottom, .trailing], 8)
                            
                        } else {
                            Button(action: { product.quantity = 1 }) {
                                VStack {
                                    Text("ADD")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.pink)
                                    
                                    if product.hasOptions {
                                        Text("2 options")
                                            .font(.system(size: 8))
                                            .foregroundColor(.gray)
                                    }
                                }
                                .frame(width: 65, height: 32)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.white)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .strokeBorder(
                                            Color.pink,
                                            lineWidth: 1.5
                                        )
                                )
                                .shadow(
                                    color: Color.black.opacity(0.1),
                                    radius: 3,
                                    x: 0,
                                    y: 2
                                )
                            }
                            .padding(.bottom, 8)
                            .padding(.trailing, 8)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: 140, height: 180)
            .background(Color.green.opacity(0.1))
            .cornerRadius(16)
        
            VStack(alignment: .leading, spacing: 5) {
                HStack(alignment: .center, spacing: 6) {
                    Text("₹\(product.currentPrice)")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 3)
                        .background(
                            Color(red: 16/255, green: 110/255, blue: 43/255)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    
                    Text("₹\(product.originalPrice)")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                        .strikethrough()
                }
                .padding(.top, 18)
                
                Text(product.discountText)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(
                        Color(red: 16/255, green: 110/255, blue: 43/255)
                    )
                
                Text(product.title)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.black.opacity(0.85))
                    .lineLimit(2)
                    .frame(height: 36, alignment: .topLeading)
                
                Text(product.volumeInfo)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                
                Text(product.finishTag)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(
                        Color(red: 20/255, green: 110/255, blue: 130/255)
                    )
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Color(red: 232/255, green: 247/255, blue: 250/255)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                
                HStack(spacing: 3) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 10))
                        .foregroundColor(
                            Color(red: 16/255, green: 110/255, blue: 43/255)
                        )
                    Text(String(format: "%.1f", product.rating))
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.black)
                    Text(product.ratingCountText)
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                }
                .padding(.top, 2)
                
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
                                .stroke(
                                    style: StrokeStyle(
                                        lineWidth: 1,
                                        lineCap: .round,
                                        lineJoin: .miter,
                                        dash: [1, 2]
                                    )
                                )
                                .foregroundColor(.blue)
                                .frame(height: 1)
                                .padding(.top, 16)
                        )
                    }
                }
            }
            .padding(.horizontal, 4)
        }
    }
}

// MARK: - Preview Setup Engine
#Preview {
    NAHorizontalGrid_NxN_V1()
}


