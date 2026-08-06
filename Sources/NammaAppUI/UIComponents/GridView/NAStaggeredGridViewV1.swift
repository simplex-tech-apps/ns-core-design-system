//
//  NAOffersGrid.swift
//  NammaAppUI
//
//  Created by apple on 19/07/26.
//

import SwiftUI

// MARK: - Models
public struct NAStaggeredGridViewV1Model: Identifiable, Hashable {
    public let id: UUID
    public let title: String
    public let subtitle: String?
    public let discountText: String?
    public let originalPrice: Int?
    public let currentPrice: Int?
    public let productImages: [String]
    public let cardType: CardVariant
    
    public enum CardVariant: Hashable {
        case topDeals
        case standardOffer
        case promoBanner
    }

    public init(
        id: UUID = UUID(),
        title: String,
        subtitle: String? = nil,
        discountText: String? = nil,
        originalPrice: Int? = nil,
        currentPrice: Int? = nil,
        productImages: [String],
        cardType: CardVariant = .standardOffer
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.discountText = discountText
        self.originalPrice = originalPrice
        self.currentPrice = currentPrice
        self.productImages = productImages
        self.cardType = cardType
    }
}

// MARK: - Main Grid Layout Canvas View
public struct NAStaggeredGridViewV1: View {
    public var heroDeal: NAStaggeredGridViewV1Model
    public var gridDeals: [NAStaggeredGridViewV1Model]
    public var gridSpacing: CGFloat
    public var horizontalPadding: CGFloat
    public var verticalPadding: CGFloat
    public var backgroundColor: Color
    public var onItemTap: ((NAStaggeredGridViewV1Model) -> Void)?
    
    public init(
        heroDeal: NAStaggeredGridViewV1Model = NAStaggeredGridViewV1.defaultHeroDeal,
        gridDeals: [NAStaggeredGridViewV1Model] = NAStaggeredGridViewV1.defaultGridDeals,
        gridSpacing: CGFloat = 8,
        horizontalPadding: CGFloat = 16,
        verticalPadding: CGFloat = 16,
        backgroundColor: Color = Color(red: 242/255, green: 242/255, blue: 244/255),
        onItemTap: ((NAStaggeredGridViewV1Model) -> Void)? = nil
    ) {
        self.heroDeal = heroDeal
        self.gridDeals = gridDeals
        self.gridSpacing = gridSpacing
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.backgroundColor = backgroundColor
        self.onItemTap = onItemTap
    }
    
    public var body: some View {
        GeometryReader { geometry in
            let availableWidth = geometry.size.width - (horizontalPadding * 2) - (gridSpacing * 2)
            let equalCardWidth = max(60, availableWidth / 3)
            let squareCardHeight = equalCardWidth
            let tallCardHeight = (squareCardHeight * 2) + gridSpacing
            
            HStack(alignment: .top, spacing: gridSpacing) {
                DynamicDealCardView(item: heroDeal)
                    .frame(width: equalCardWidth, height: tallCardHeight)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        onItemTap?(heroDeal)
                    }
                
                LazyVGrid(
                    columns: [
                        GridItem(.fixed(equalCardWidth), spacing: gridSpacing),
                        GridItem(.fixed(equalCardWidth), spacing: gridSpacing)
                    ],
                    spacing: gridSpacing
                ) {
                    ForEach(gridDeals.prefix(4)) { deal in
                        DynamicDealCardView(item: deal)
                            .frame(width: equalCardWidth, height: squareCardHeight)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                onItemTap?(deal)
                            }
                    }
                }
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, 60)
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            .background(backgroundColor)
        }
        .frame(height: calculatedTotalHeight(screenWidth: UIScreen.main.bounds.width))
        .fixedSize(horizontal: false, vertical: true)
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
    }
    
    private func calculatedTotalHeight(screenWidth: CGFloat) -> CGFloat {
        let availableWidth = screenWidth - (horizontalPadding * 2) - (gridSpacing * 2)
        let equalCardWidth = max(60, availableWidth / 3)
        let tallCardHeight = (equalCardWidth * 2) + gridSpacing
        return tallCardHeight + 16
    }
}

// MARK: - Reusable Dynamic Structural Card Component
struct DynamicDealCardView: View {
    let item: NAStaggeredGridViewV1Model
    
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
                VStack(spacing: 8) {
                    Text(item.title)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .foregroundColor(textCrimson)
                        .padding(.top, 12)
                        .padding(.horizontal, 6)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    VStack(spacing: 2) {
                        if let original = item.originalPrice {
                            Text("₹\(original)")
                                .font(.system(size: 12, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .strikethrough()
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(darkGreyBadge)
                                .cornerRadius(6)
                        }
                        
                        if let current = item.currentPrice {
                            Text("₹\(current)")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(badgePink)
                                .cornerRadius(8)
                        }
                    }
                    
                    if let sub = item.subtitle {
                        Text(sub)
                            .font(.system(size: 11, weight: .bold, design: .rounded))
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
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 24)
                        .padding(.horizontal, 4)
                        .frame(height: 42)
                    
                    ScrollableImagesContainer(images: item.productImages)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.bottom, 2)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(
                    HStack(spacing: 0) {
                        Text("Up to")
                            .font(.system(size: 9, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 4)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(darkGreyBadge)
                        
                        if let discount = item.discountText {
                            Text(discount)
                                .font(.system(size: 9, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 4)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(badgePink)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 20)
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
                    if let firstImg = item.productImages.first {
                        Image(firstImg, bundle: .module)
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 6)
                    }
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

struct ScrollableImagesContainer: View {
    let images: [String]
    
    var body: some View {
        GeometryReader { geo in
            let cardWidth = geo.size.width
            let cardHeight = geo.size.height
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(Array(images.enumerated()), id: \.offset) { _, imgAsset in
                        Image(imgAsset, bundle: .module)
                            .resizable()
                            .scaledToFit()
                            .frame(width: cardWidth, height: cardHeight)
                            .clipped()
                    }
                }
            }
            .scrollTargetBehavior(.paging)
        }
        .clipped()
    }
}

// MARK: - Default Input Parameters
extension NAStaggeredGridViewV1 {
    public static let defaultHeroDeal = NAStaggeredGridViewV1Model(
        title: "TOP\nDEALS",
        subtitle: "Fresh Meat\n& Poultry",
        discountText: nil,
        originalPrice: 299,
        currentPrice: 229,
        productImages: ["chicken_product", "chicken_product"],
        cardType: .topDeals
    )
    
    public static let defaultGridDeals: [NAStaggeredGridViewV1Model] = [
        NAStaggeredGridViewV1Model(
            title: "Chicken",
            discountText: "6% OFF",
            productImages: ["chicken_product", "chicken_product"],
            cardType: .standardOffer
        ),
        NAStaggeredGridViewV1Model(
            title: "Mutton",
            discountText: "10% OFF",
            productImages: ["chicken_product", "chicken_product"],
            cardType: .standardOffer
        ),
        NAStaggeredGridViewV1Model(
            title: "Fish",
            discountText: "5% OFF",
            productImages: ["chicken_product", "chicken_product"],
            cardType: .standardOffer
        ),
        NAStaggeredGridViewV1Model(
            title: "Eggs",
            discountText: "8% OFF",
            productImages: ["chicken_product", "chicken_product"],
            cardType: .standardOffer
        )
    ]
}

struct NAStaggeredGridViewV1DemoScreen: View {
    var body: some View {
        NAStaggeredGridViewV1(
            heroDeal: NAStaggeredGridViewV1.defaultHeroDeal,
            gridDeals: NAStaggeredGridViewV1.defaultGridDeals,
            gridSpacing: 10,
            horizontalPadding: 16,
            verticalPadding: 16
        ) { selectedDeal in
            print("Selected deal: \(selectedDeal.title)")
        }
    }
}

#Preview {
    List {
        NAStaggeredGridViewV1DemoScreen()
    }
    .listStyle(.plain)
    .listRowSpacing(0)
}
