//
//  NAOffersGrid.swift
//  NammaAppUI
//
//  Created by apple on 19/07/26.
//

import SwiftUI

// MARK: - Models
struct DealCardItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String?
    let discountText: String?
    let originalPrice: Int?
    let currentPrice: Int?
    let productImages: [String]
    let cardType: CardVariant
    
    enum CardVariant {
        case topDeals
        case standardOffer
        case promoBanner
    }
}

// MARK: - Main Grid Layout Canvas View
struct NAStaggeredGridViewV1: View {
    let gridDeals = [
        DealCardItem(
            title: "Chicken",
            subtitle: nil,
            discountText: "6% OFF",
            originalPrice: nil,
            currentPrice: nil,
            productImages: ["chicken_product", "chicken_product", "chicken_product"],
            cardType: .standardOffer
        ),
        DealCardItem(
            title: "Mutton",
            subtitle: nil,
            discountText: "10% OFF",
            originalPrice: nil,
            currentPrice: nil,
            productImages: ["chicken_product", "chicken_product", "chicken_product"],
            cardType: .standardOffer
        ),
        DealCardItem(
            title: "Eggs",
            subtitle: nil,
            discountText: "5% OFF",
            originalPrice: nil,
            currentPrice: nil,
            productImages: ["chicken_product", "chicken_product", "chicken_product"],
            cardType: .standardOffer
        ),
        DealCardItem(
            title: "BIG BRANDS\nBIG OFFERS",
            subtitle: nil,
            discountText: nil,
            originalPrice: nil,
            currentPrice: nil,
            productImages: ["chicken_product"],
            cardType: .promoBanner
        )
    ]
    
    let heroDeal = DealCardItem(
        title: "TOP\nDEALS",
        subtitle: "Tinted Lip\nBalm",
        discountText: nil,
        originalPrice: 299,
        currentPrice: 229,
        productImages: ["chicken_product", "chicken_product"],
        cardType: .topDeals
    )
    
    var body: some View {
        GeometryReader { geometry in
            let equalCardWidth = (geometry.size.width - 32) / 3
            let gridSpacing: CGFloat = 8
            let squareCardHeight = equalCardWidth
            let tallCardHeight = (squareCardHeight * 2) + gridSpacing
            
            VStack(spacing: 0) {
                HStack(alignment: .top, spacing: 8) {
                    DynamicDealCardView(item: heroDeal)
                        .frame(width: equalCardWidth, height: tallCardHeight)
                    
                    LazyVGrid(
                        columns: [
                            GridItem(.fixed(equalCardWidth), spacing: gridSpacing),
                            GridItem(.fixed(equalCardWidth), spacing: gridSpacing)
                        ],
                        spacing: gridSpacing
                    ) {
                        ForEach(gridDeals) { deal in
                            DynamicDealCardView(item: deal)
                                .frame(width: equalCardWidth, height: squareCardHeight)
                        }
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8) 
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color(red: 255/255, green: 212/255, blue: 225/255))
        }
        .frame(height: calculatedTotalHeight(screenWidth: UIScreen.main.bounds.width))
        .fixedSize(horizontal: false, vertical: true)
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
    }
    
    private func calculatedTotalHeight(screenWidth: CGFloat) -> CGFloat {
        let horizontalPadding: CGFloat = 24
        let totalInnerSpacing: CGFloat = 16
        let equalCardWidth = (screenWidth - horizontalPadding - totalInnerSpacing) / 3
        let gridSpacing: CGFloat = 8
        let tallCardHeight = (equalCardWidth * 2) + gridSpacing
        return tallCardHeight + 16
    }
}

// MARK: - Reusable Dynamic Structural Card Component
struct DynamicDealCardView: View {
    let item: DealCardItem
    
    private let textCrimson = Color(red: 245/255, green: 60/255, blue: 110/255)
    private let badgePink = Color(red: 254/255, green: 98/255, blue: 137/255)
    private let darkGreyBadge = Color(red: 50/255, green: 50/255, blue: 50/255)
    
    private var topDealsGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 255/255, green: 248/255, blue: 240/255),
                Color(red: 255/255, green: 253/255, blue: 248/255),
                Color.white
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    private var standardCardGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color.white,
                Color(red: 255/255, green: 254/255, blue: 250/255)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if item.cardType == .topDeals {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(topDealsGradient)
            } else if item.cardType == .standardOffer {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(standardCardGradient)
            }
            
            switch item.cardType {
            case .topDeals:
                VStack(spacing: 12) {
                    Text(attributedString(for: item.title))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .foregroundColor(textCrimson)
                        .lineSpacing(-6)
                        .padding(.top, 14)
                        .padding(.horizontal, 8)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    VStack(spacing: 0) {
                        if let original = item.originalPrice {
                            Text("₹\(original)")
                                .font(.system(size: 13, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .strikethrough()
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(darkGreyBadge)
                                .cornerRadius(6)
                        }
                        
                        if let current = item.currentPrice {
                            Text("₹\(current)")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 5)
                                .background(badgePink)
                                .cornerRadius(8)
                        }
                    }
                    
                    if let sub = item.subtitle {
                        Text(sub)
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .foregroundColor(darkGreyBadge)
                            .multilineTextAlignment(.center)
                    }
                    
                    ScrollableImagesContainer(images: item.productImages)
                        .frame(maxHeight: .infinity)
                }
                .frame(maxWidth: .infinity)
                
            case .standardOffer:
                VStack(alignment: .leading, spacing: 0) {
                    Text(item.title)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 28)
                        .padding(.horizontal, 4)
                        .frame(height: 64)
                    
                    Spacer(minLength: 2)
                    
                    ScrollableImagesContainer(images: item.productImages)
                        .frame(maxHeight: .infinity)
                        .padding(.bottom, 6)
                }
                .frame(maxWidth: .infinity)
                .overlay(
                    HStack(spacing: 0) {
                        Text("Up to")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 6)
                            .frame(maxWidth: .infinity, maxHeight: .infinity) // 🎯 Fills left half evenly
                            .background(darkGreyBadge)
                        
                        if let discount = item.discountText {
                            Text(discount)
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 6)
                                .frame(maxWidth: .infinity, maxHeight: .infinity) // 🎯 Fills right half evenly
                                .background(badgePink)
                        }
                    }
                    .frame(maxWidth: .infinity) // 🎯 Expands the banner across the full card width
                    .frame(height: 24)
                    .clipShape(UnevenRoundedRectangle(
                        topLeadingRadius: 24,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 24
                    )),
                    alignment: .top
                )
                
            case .promoBanner:
                VStack(spacing: 0) {
                    Image("chicken_product", bundle: .module)
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 6)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    RadialGradient(
                        colors: [
                            Color.white,
                            Color(red: 255/255, green: 244/255, blue: 246/255)
                        ],
                        center: .center,
                        startRadius: 2,
                        endRadius: 80
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 3)
    }
}

// MARK: - Dynamic Paging Scrollable Image Engine
struct ScrollableImagesContainer: View {
    let images: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 0) {
                ForEach(images, id: \.self) { imgAsset in
                    Image(imgAsset, bundle: .module)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(1.5)
                        .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
                }
            }
        }
        .scrollTargetBehavior(.paging)
    }
}

// MARK: - Preview Setup Engine
#Preview {
    List {
        NAStaggeredGridViewV1()
    }
    .listStyle(.plain)
    .listRowSpacing(0)
}
