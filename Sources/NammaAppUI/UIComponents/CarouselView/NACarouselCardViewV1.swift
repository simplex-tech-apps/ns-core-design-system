//
//  NAProductCarouselCard.swift
//  NammaAppUI
//
//  Created by apple on 19/07/26.
//

import SwiftUI

// MARK: - Individual Dynamic Component Layout Card
public struct NACarouselCardViewV1: View {
    @Binding public var item: NACarouselV1Model

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

    public init(
        item: Binding<NACarouselV1Model>,
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
        self._item = item
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
        VStack(alignment: .leading, spacing: 0) {
            // MARK: - Top Image & Stepper Container
            ZStack(alignment: .bottom) {
                topCardBackgroundColor
                
                Image(item.productImage, bundle: .module)
                    .resizable()
                    .scaledToFill()
                    .frame(height: imageHeight)
                    .clipped()
                
                HStack(alignment: .center) {
                    Text(item.volumeInfo)
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.primary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.white)
                        .cornerRadius(6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 0.8)
                        )
                        .padding(.leading, 8)
                        .padding(.bottom, 8)
                    
                    Spacer()

                    ZStack {
                        if item.quantity > 0 {
                            HStack(spacing: 8) {
                                Button(action: {
                                    item.quantity -= 1
                                    onClickRemove?(item)
                                }) {
                                    Image(systemName: "minus")
                                        .font(.system(size: 10, weight: .bold))
                                }
                                
                                Text("\(item.quantity)")
                                    .font(.system(size: 11, weight: .bold))
                                
                                Button(action: {
                                    item.quantity += 1
                                    onClickAdd?(item)
                                }) {
                                    Image(systemName: "plus")
                                        .font(.system(size: 10, weight: .bold))
                                }
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 8)
                            .background(Color(red: 226/255, green: 18/255, blue: 73/255))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        } else {
                            Button(action: {
                                if item.hasOptions {
                                    onClickOptions?(item)
                                } else {
                                    item.quantity = 1
                                    onClickInitialAdd?(item)
                                }
                            }) {
                                VStack(spacing: 1) {
                                    Text("ADD")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(accentColor)
                                }
                                .frame(width: 52, height: 34)
                                .background(Color.white, in: RoundedRectangle(cornerRadius: 8))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(accentColor, lineWidth: 1)
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.trailing, 8)
                    .padding(.bottom, 8)
                }
            }
            .frame(height: imageHeight)
            .clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: cornerRadius,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: cornerRadius,
                    style: .continuous
                )
            )
            
            // MARK: - Bottom Details Section
            ZStack(alignment: .center) {
                Color.white
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack(alignment: .center, spacing: 6) {
                        Text("₹\(item.currentPrice)")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(topCardBackgroundColor)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                        
                        Text("₹\(item.originalPrice)")
                            .font(.system(size: 13))
                            .foregroundColor(.secondary)
                            .strikethrough()
                        
                        Spacer()
                        
                        HStack(spacing: 3) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 10))
                                .foregroundColor(topCardBackgroundColor)
                            
                            Text(String(format: "%.1f", item.rating))
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.black)
                            
                            Text("(\(item.ratingCountText))")
                                .font(.system(size: 11))
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 2)
                    }
                    
                    Text(item.discountText)
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(topCardBackgroundColor)
                    
                    Text(item.title)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.black.opacity(0.85))
                        .lineLimit(1)
                    
                    if let promo = item.promotionText, !promo.isEmpty {
                        Button(action: {
                            onClickPromotion?(item)
                        }) {
                            HStack(spacing: 3) {
                                Text(promo)
                                    .font(.system(size: 11, weight: .bold))
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 8, weight: .bold))
                            }
                            .foregroundColor(.blue)
                            .padding(.top, 2)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 12)
            }
            .frame(height: detailHeight)
            .clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: cornerRadius,
                    bottomTrailingRadius: cornerRadius,
                    topTrailingRadius: 0,
                    style: .continuous
                )
            )
        }
        .frame(width: cardWidth)
        .background(Color.clear)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
        .contentShape(Rectangle())
        .onTapGesture {
            onItemTap?(item)
        }
    }
}

// MARK: - Interactive Preview Demo Screen
struct NACarouselCardViewV1DemoScreen: View {
    @State private var item = NACarouselV1Model(
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
        quantity: 2,
        hasOptions: true,
        promotionText: "Buy 1/2 kg, get 1 egg FREE!"
    )

    var body: some View {
        NACarouselCardViewV1(
            item: $item,
            cardWidth: 320,
            imageHeight: 240,
            detailHeight: 120,
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
    NACarouselCardViewV1DemoScreen()
}
