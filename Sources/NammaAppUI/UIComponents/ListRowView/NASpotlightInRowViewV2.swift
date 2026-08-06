//
//  NASpotlightInRowViewV2.swift
//  NammaAppUI
//
//  Created by apple on 20/07/26.
//

import SwiftUI

// MARK: - Main Catalog View
public struct NASpotlightInRowViewV2: View {
    @Binding public var items: [NAProductCardViewV1Model]

    public var title: String
    public var subtitle: String?
    public var headerImage: String
    public var backgroundColor: Color
    public var cardWidth: CGFloat
    public var cardSpacing: CGFloat
    
    public var onClickAdd: ((NAProductCardViewV1Model) -> Void)?
    public var onClickRemove: ((NAProductCardViewV1Model) -> Void)?
    public var onClickInitialAdd: ((NAProductCardViewV1Model) -> Void)?
    public var onClickFavourite: ((NAProductCardViewV1Model) -> Void)?
    public var onItemTap: ((NAProductCardViewV1Model) -> Void)?
    public var onClickSeeAll: (() -> Void)?

    public init(
        items: Binding<[NAProductCardViewV1Model]>,
        title: String = "Lowest Prices\nEveryday",
        subtitle: String? = nil,
        headerImage: String = "vegetables",
        backgroundColor: Color = Color(red: 29/255, green: 78/255, blue: 137/255),
        cardWidth: CGFloat = 175,
        cardSpacing: CGFloat = 14,
        onClickAdd: ((NAProductCardViewV1Model) -> Void)? = nil,
        onClickRemove: ((NAProductCardViewV1Model) -> Void)? = nil,
        onClickInitialAdd: ((NAProductCardViewV1Model) -> Void)? = nil,
        onClickFavourite: ((NAProductCardViewV1Model) -> Void)? = nil,
        onItemTap: ((NAProductCardViewV1Model) -> Void)? = nil,
        onClickSeeAll: (() -> Void)? = nil
    ) {
        self._items = items
        self.title = title
        self.subtitle = subtitle
        self.headerImage = headerImage
        self.backgroundColor = backgroundColor
        self.cardWidth = cardWidth
        self.cardSpacing = cardSpacing
        self.onClickAdd = onClickAdd
        self.onClickRemove = onClickRemove
        self.onClickInitialAdd = onClickInitialAdd
        self.onClickFavourite = onClickFavourite
        self.onItemTap = onItemTap
        self.onClickSeeAll = onClickSeeAll
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .top) {
                Image(headerImage, bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 55, height: 55)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundColor(.white.opacity(0.85))
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: cardSpacing) {
                    ForEach($items) { $item in
                        NAProductCardViewV1(
                            item: $item,
                            onClickAdd: { updatedProduct in
                                onClickAdd?(updatedProduct)
                            },
                            onClickRemove: { updatedProduct in
                                onClickRemove?(updatedProduct)
                            },
                            onClickInitialAdd: { updatedProduct in
                                onClickInitialAdd?(updatedProduct)
                            },
                            onClickFavourite: { updatedProduct in
                                onClickFavourite?(updatedProduct)
                            },
                            onItemTap: { selectedProduct in
                                onItemTap?(selectedProduct)
                            }
                        )
                        .frame(width: cardWidth)
                    }
                }
                .padding(.horizontal, 16)
            }

            SeeAllButtonViewV1 {
                onClickSeeAll?()
            }
            .padding(16)
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        .background(backgroundColor)
    }
}

// MARK: - Demo Screen
struct NASpotlightInRowViewV2DemoScreen: View {
    @State private var items = [
        NAProductCardViewV1Model(
            title: "Lay's American Cream & Onion Flavour | Potato Chips",
            weightInfo: "1 pack (80 g)",
            flavourTag: "Cream & Onion",
            currentPrice: 38,
            originalPrice: 48,
            discountText: "₹10 OFF",
            rating: 4.7,
            ratingCountText: "(52k)",
            productImage: "vegetables",
            quantity: 0
        ),
        NAProductCardViewV1Model(
            title: "Lay's India's Magic Masala | Crunchy Potato Chips",
            weightInfo: "1 pack (82 g or 80 g)",
            flavourTag: "Magic Masala",
            currentPrice: 38,
            originalPrice: 48,
            discountText: "₹10 OFF",
            rating: 4.9,
            ratingCountText: "(65k)",
            productImage: "vegetables",
            quantity: 1
        ),
        NAProductCardViewV1Model(
            title: "Lay's Spanish Tomato Tango Flavour | Potato Chips",
            weightInfo: "1 pack (80 g)",
            flavourTag: "Tomato",
            currentPrice: 38,
            originalPrice: 48,
            discountText: "₹10 OFF",
            rating: 4.8,
            ratingCountText: "(18k)",
            productImage: "vegetables",
            quantity: 0
        )
    ]
    
    var body: some View {
        NASpotlightInRowViewV2(
            items: $items,
            title: "Lowest Prices\nEveryday",
            subtitle: "Flat 20% Cashback",
            headerImage: "vegetables",
            backgroundColor: Color(red: 89/255, green: 178/255, blue: 137/255),
            cardWidth: 175,
            cardSpacing: 14,
            onClickAdd: { item in
                
            },
            onClickRemove: { item in
                
            },
            onClickInitialAdd: { item in
               
            },
            onClickFavourite: { item in
                
            },
            onItemTap: { selectedItem in
                
            },
            onClickSeeAll: {
                
            }
        )
    }
}

// MARK: - Preview
#Preview {
    NASpotlightInRowViewV2DemoScreen()
}
