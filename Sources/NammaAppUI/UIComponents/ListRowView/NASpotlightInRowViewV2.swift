//
//  NASpotlightInRowViewV1.swift
//  NammaAppUI
//
//  Created by apple on 20/07/26.
//

import SwiftUI

// MARK: - Product Model
struct ProductItem: Identifiable {
    let id = UUID()
    let title: String
    let weightInfo: String
    let flavourTag: String
    let currentPrice: Int
    let originalPrice: Int
    let discountText: String
    let rating: Double
    let ratingCountText: String
    let productImage: String
    var isFavorite: Bool = false
}

// MARK: - Main Catalog View
struct NASpotlightInRowViewV2: View {
    @State private var products = [
        ProductItem(title: "Lay's American Cream & Onion Flavour | Potato Chips", weightInfo: "1 pack (80 g)", flavourTag: "Cream & Onion", currentPrice: 38, originalPrice: 48, discountText: "₹10 OFF", rating: 4.7, ratingCountText: "(52k)", productImage: "lays_green"),
        ProductItem(title: "Lay's India's Magic Masala | Crunchy Potato Chips", weightInfo: "1 pack (82 g or 80 g)", flavourTag: "Magic Masala", currentPrice: 38, originalPrice: 48, discountText: "₹10 OFF", rating: 4.9, ratingCountText: "(65k)", productImage: "lays_blue"),
        ProductItem(title: "Lay's Spanish Tomato Tango Flavour | Potato Chips", weightInfo: "1 pack (80 g)", flavourTag: "Tomato", currentPrice: 38, originalPrice: 48, discountText: "₹10 OFF", rating: 4.8, ratingCountText: "(18k)", productImage: "lays_red"),
        ProductItem(title: "Lay's American Cream & Onion Flavour | Potato Chips", weightInfo: "1 pack (80 g)", flavourTag: "Cream & Onion", currentPrice: 38, originalPrice: 48, discountText: "₹10 OFF", rating: 4.7, ratingCountText: "(52k)", productImage: "lays_green"),
        ProductItem(title: "Lay's India's Magic Masala | Crunchy Potato Chips", weightInfo: "1 pack (82 g or 80 g)", flavourTag: "Magic Masala", currentPrice: 38, originalPrice: 48, discountText: "₹10 OFF", rating: 4.9, ratingCountText: "(65k)", productImage: "lays_blue"),
        ProductItem(title: "Lay's Spanish Tomato Tango Flavour | Potato Chips", weightInfo: "1 pack (80 g)", flavourTag: "Tomato", currentPrice: 38, originalPrice: 48, discountText: "₹10 OFF", rating: 4.8, ratingCountText: "(18k)", productImage: "lays_red")
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .top) {
                Image("vegetables", bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 55, height: 55)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text("Lowest Prices\nEveryday")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach($products) { $product in
                        NAProductCardViewV1(product: $product)
                            .frame(width: 165)
                    }
                }
                .padding(.horizontal, 16)
            }
            
            SeeAllButtonViewV1 {
                print("See All tapped!")
            }
            .padding(16)
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        .background(Color(red: 29/255, green: 78/255, blue: 137/255))
    }
}

// MARK: - Preview Setup Engine
#Preview {
    NASpotlightInRowViewV2()
}
