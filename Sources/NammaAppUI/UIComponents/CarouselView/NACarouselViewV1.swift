//
//  NACategoryOfProductsCarouselView.swift
//  NammaAppUI
//
//  Created by apple on 19/07/26.
//

import SwiftUI

// MARK: - Promo Model
public struct NACarouselV1Model: Identifiable, Hashable {
    public let id: UUID
    public var title: String
    public var volumeInfo: String
    public var finishTag: String
    public var currentPrice: Int
    public var originalPrice: Int
    public var discountText: String
    public var rating: Double
    public var ratingCountText: String
    public var productImage: String
    public var isFavorite: Bool
    public var quantity: Int
    public var hasOptions: Bool
    public var promotionText: String?
    
    public init(
        id: UUID = UUID(),
        title: String,
        volumeInfo: String,
        finishTag: String,
        currentPrice: Int,
        originalPrice: Int,
        discountText: String,
        rating: Double,
        ratingCountText: String,
        productImage: String,
        isFavorite: Bool = false,
        quantity: Int = 0,
        hasOptions: Bool = false,
        promotionText: String? = nil
    ) {
        self.id = id
        self.title = title
        self.volumeInfo = volumeInfo
        self.finishTag = finishTag
        self.currentPrice = currentPrice
        self.originalPrice = originalPrice
        self.discountText = discountText
        self.rating = rating
        self.ratingCountText = ratingCountText
        self.productImage = productImage
        self.isFavorite = isFavorite
        self.quantity = quantity
        self.hasOptions = hasOptions
        self.promotionText = promotionText
    }
}

// MARK: - Dynamic Carousel Container Component
public struct NACarouselViewV1: View {
    @Binding public var items: [NACarouselV1Model]
    
    public var cardWidth: CGFloat
    public var imageHeight: CGFloat
    public var detailHeight: CGFloat
    public var cornerRadius: CGFloat
    public var topCardBackgroundColor: Color
    public var accentColor: Color

    public var onClickAdd: ((NACarouselV1Model) -> Void)?
    public var onClickRemove: ((NACarouselV1Model) -> Void)?
    public var onClickInitialAdd: ((NACarouselV1Model) -> Void)?
    public var onClickOptions: ((NACarouselV1Model) -> Void)?
    public var onClickPromotion: ((NACarouselV1Model) -> Void)?
    public var onItemTap: ((NACarouselV1Model) -> Void)?
    
    @State private var activeScrollID: UUID?
    
    private var calculatedCardHeight: CGFloat {
        imageHeight + detailHeight
    }

    public init(
        items: Binding<[NACarouselV1Model]>,
        cardWidth: CGFloat = 320,
        imageHeight: CGFloat = 240,
        detailHeight: CGFloat = 120,
        cornerRadius: CGFloat = 32,
        topCardBackgroundColor: Color = Color(red: 16/255, green: 110/255, blue: 43/255),
        accentColor: Color = Color(red: 45/255, green: 115/255, blue: 55/255),
        onClickAdd: ((NACarouselV1Model) -> Void)? = nil,
        onClickRemove: ((NACarouselV1Model) -> Void)? = nil,
        onClickInitialAdd: ((NACarouselV1Model) -> Void)? = nil,
        onClickOptions: ((NACarouselV1Model) -> Void)? = nil,
        onClickPromotion: ((NACarouselV1Model) -> Void)? = nil,
        onItemTap: ((NACarouselV1Model) -> Void)? = nil
    ) {
        self._items = items
        self.cardWidth = cardWidth
        self.imageHeight = imageHeight
        self.detailHeight = detailHeight
        self.cornerRadius = cornerRadius
        self.topCardBackgroundColor = topCardBackgroundColor
        self.accentColor = accentColor
        self.onClickAdd = onClickAdd
        self.onClickRemove = onClickRemove
        self.onClickInitialAdd = onClickInitialAdd
        self.onClickOptions = onClickOptions
        self.onClickPromotion = onClickPromotion
        self.onItemTap = onItemTap
    }
    
    public var body: some View {
        GeometryReader { outerGeometry in
            let screenWidth = outerGeometry.size.width
            let sidePadding = max(16, (screenWidth - cardWidth) / 2)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 8) {
                    ForEach($items) { $item in
                        GeometryReader { cardGeometry in
                            let midX = cardGeometry.frame(in: .global).midX
                            let screenMidX = screenWidth / 2
                            let distanceFromCenter = abs(screenMidX - midX)
                            
                            let rawScale = 1.0 - (distanceFromCenter / screenWidth) * 0.4
                            let activeScale = max(0.90, min(1.0, rawScale))

                            NACarouselCardViewV1(
                                item: $item,
                                cardWidth: cardWidth,
                                imageHeight: imageHeight,
                                detailHeight: detailHeight,
                                cornerRadius: cornerRadius,
                                topCardBackgroundColor: topCardBackgroundColor,
                                accentColor: accentColor,
                                onClickAdd: { updatedItem in
                                    onClickAdd?(updatedItem)
                                },
                                onClickRemove: { updatedItem in
                                    onClickRemove?(updatedItem)
                                },
                                onClickInitialAdd: { updatedItem in
                                    onClickInitialAdd?(updatedItem)
                                },
                                onClickOptions: { updatedItem in
                                    onClickOptions?(updatedItem)
                                },
                                onClickPromotion: { updatedItem in
                                    onClickPromotion?(updatedItem)
                                },
                                onItemTap: { selectedItem in
                                    onItemTap?(selectedItem)
                                }
                            )
                            .scaleEffect(activeScale)
                            .animation(
                                .interactiveSpring(response: 0.35, dampingFraction: 0.8),
                                value: distanceFromCenter
                            )
                        }
                        .frame(width: cardWidth, height: calculatedCardHeight)
                        .id(item.id)
                    }
                }
                .padding(.horizontal, sidePadding)
                .padding(.vertical, 16)
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $activeScrollID)
            .frame(height: calculatedCardHeight + 32)
        }
        .frame(height: calculatedCardHeight + 32)
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
    }
}

// MARK: - Demo Usage
struct NACarouselViewV1DemoScreen: View {
    @State var items = [
        NACarouselV1Model(
            title: "Premium Tender Chicken Curry Cut",
            volumeInfo: "500g",
            finishTag: "Freshly Cut",
            currentPrice: 179,
            originalPrice: 220,
            discountText: "18% OFF",
            rating: 4.8,
            ratingCountText: "1.2k ratings",
            productImage: "chicken_product",
            isFavorite: false,
            quantity: 0,
            hasOptions: false,
            promotionText: "Buy 1/2 kg, get 1 egg FREE!"
        ),
        
        NACarouselV1Model(
            title: "Lean Mutton Curry Cut (Bone-in)",
            volumeInfo: "500g",
            finishTag: "Premium Halal",
            currentPrice: 449,
            originalPrice: 499,
            discountText: "10% OFF",
            rating: 4.9,
            ratingCountText: "850 ratings",
            productImage: "chicken_product",
            isFavorite: true,
            quantity: 1,
            hasOptions: true,
            promotionText: "Buy 1 kg, get 2 eggs FREE!"
        ),
        
        NACarouselV1Model(
            title: "Country Chicken / Nattu Kozhi",
            volumeInfo: "1kg",
            finishTag: "Skin-on",
            currentPrice: 380,
            originalPrice: 420,
            discountText: "9% OFF",
            rating: 4.7,
            ratingCountText: "420 ratings",
            productImage: "chicken_product",
            isFavorite: false,
            quantity: 0,
            hasOptions: false,
            promotionText: "Locally Sourced"
        ),
        
        NACarouselV1Model(
            title: "Fresh Boneless Chicken Breast Platter",
            volumeInfo: "450g",
            finishTag: "Cleaned & Antibiotic-Free",
            currentPrice: 219,
            originalPrice: 260,
            discountText: "15% OFF",
            rating: 4.6,
            ratingCountText: "2.1k ratings",
            productImage: "vegetables",
            isFavorite: false,
            quantity: 0,
            hasOptions: false,
            promotionText: "High Protein Pick"
        )
    ]
    
    var body: some View {
        NACarouselViewV1(
            items: $items,
            cardWidth: 300,
            imageHeight: 220,
            detailHeight: 120,
            cornerRadius: 24,
            topCardBackgroundColor: Color(red: 20/255, green: 80/255, blue: 50/255),
            accentColor: Color(red: 226/255, green: 18/255, blue: 73/255),
            onClickAdd: { item in
                
            },
            onClickRemove: { item in
               
            },
            onClickInitialAdd: { item in
                
            },
            onClickOptions: { item in
                
            },
            onClickPromotion: { item in
            
            },
            onItemTap: { item in
                
            }
        )
    }
}

// MARK: - Preview Setup Engine
#Preview {
    NACarouselViewV1DemoScreen()
}
