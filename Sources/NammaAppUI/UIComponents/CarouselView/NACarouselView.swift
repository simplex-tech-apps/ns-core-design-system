//
//  NACategoryOfProductsCarouselView.swift
//  NammaAppUI
//
//  Created by apple on 19/07/26.
//

import SwiftUI

// MARK: - Promo Model
struct ProductCarouselModel: Identifiable, Hashable {
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

struct NACarouselView: View {
    let products = [
        ProductCarouselModel(
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
        ),
        
        ProductCarouselModel(
            title: "Lean Mutton Curry Cut (Bone-in)",
            volumeInfo: "500g",
            finishTag: "Premium Halal",
            currentPrice: 449,
            originalPrice: 499,
            discountText: "10% OFF",
            rating: 4.9,
            ratingCountText: "850 ratings",
            productImage: "mutton_curry_cut",
            isFavorite: true,
            quantity: 0,
            hasOptions: true,
            promotionText: "Buy 1 kg, get 2 eggs FREE!"
        ),
        
        ProductCarouselModel(
            title: "Country Chicken / Nattu Kozhi",
            volumeInfo: "1kg",
            finishTag: "Skin-on",
            currentPrice: 380,
            originalPrice: 420,
            discountText: "9% OFF",
            rating: 4.7,
            ratingCountText: "420 ratings",
            productImage: "nattu_kozhi_whole",
            isFavorite: false,
            quantity: 0,
            hasOptions: false,
            promotionText: "Locally Sourced"
        ),
        
        ProductCarouselModel(
            title: "Fresh Boneless Chicken Breast Platter",
            volumeInfo: "450g",
            finishTag: "Cleaned & Antibiotic-Free",
            currentPrice: 219,
            originalPrice: 260,
            discountText: "15% OFF",
            rating: 4.6,
            ratingCountText: "2.1k ratings",
            productImage: "chicken_breast_boneless",
            isFavorite: false,
            quantity: 0,
            hasOptions: false,
            promotionText: "High Protein Pick"
        ),
        
        ProductCarouselModel(
            title: "Premium Goat Mutton Mince / Keema",
            volumeInfo: "250g",
            finishTag: "Finely Minced",
            currentPrice: 259,
            originalPrice: 299,
            discountText: "13% OFF",
            rating: 4.9,
            ratingCountText: "310 ratings",
            productImage: "mutton_keema_fresh",
            isFavorite: false,
            quantity: 0,
            hasOptions: true,
            promotionText: "Perfect for Kebabs & Gravy"
        )
    ]
    
    @State private var activeScrollID: UUID?
    
    var body: some View {
        GeometryReader { outerGeometry in
            let screenWidth = outerGeometry.size.width
            let cardWidth: CGFloat = 320
            let cardHeight: CGFloat = 360
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 8) {
                    ForEach(products) { item in
                        GeometryReader { cardGeometry in
                            let midX = cardGeometry.frame(in: .global).midX
                            let screenMidX = screenWidth / 2
                            let distanceFromCenter = abs(screenMidX - midX)
                            
                            let rawScale = 1.0 - (distanceFromCenter / screenWidth) * 0.4
                            let activeScale = max(0.90, min(1.0, rawScale))
                            let activeOpacity = max(0.6, min(1.0, 1.0 - (distanceFromCenter / screenWidth) * 0.5))

                            NAProductCarouselCardView(product: item)
                                .scaleEffect(activeScale)
                                .animation(.interactiveSpring(response: 0.35, dampingFraction: 0.8), value: distanceFromCenter)
                        }
                        .frame(width: cardWidth, height: cardHeight)
                        .id(item.id)
                    }
                }
                .padding(.horizontal, (screenWidth - cardWidth) / 2)
                .padding(.vertical, 16)
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $activeScrollID)
            .frame(height: cardHeight + 32)
        }
        .frame(height: 392)
    }
}

// MARK: - Preview Setup Engine
#Preview {
    NACarouselView()
}
