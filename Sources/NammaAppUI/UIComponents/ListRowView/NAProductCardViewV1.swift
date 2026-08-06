//
//  NAProductCardViewV1.swift
//  NammaAppUI
//
//  Created by apple on 21/07/26.
//

import SwiftUI

// MARK: - Product Model
public struct NAProductCardViewV1Model: Identifiable, Equatable {
    public let id: UUID
    public var title: String
    public var weightInfo: String
    public var flavourTag: String
    public var currentPrice: Int
    public var originalPrice: Int
    public var discountText: String
    public var rating: Double
    public var ratingCountText: String
    public var productImage: String
    public var isFavorite: Bool
    public var quantity: Int
    
    public init(
        id: UUID = UUID(),
        title: String,
        weightInfo: String,
        flavourTag: String,
        currentPrice: Int,
        originalPrice: Int,
        discountText: String,
        rating: Double,
        ratingCountText: String,
        productImage: String,
        isFavorite: Bool = false,
        quantity: Int = 0
    ) {
        self.id = id
        self.title = title
        self.weightInfo = weightInfo
        self.flavourTag = flavourTag
        self.currentPrice = currentPrice
        self.originalPrice = originalPrice
        self.discountText = discountText
        self.rating = rating
        self.ratingCountText = ratingCountText
        self.productImage = productImage
        self.isFavorite = isFavorite
        self.quantity = quantity
    }
}

// MARK: - Individual Product Card View
public struct NAProductCardViewV1: View {
    @Binding public var item: NAProductCardViewV1Model

    public var onClickAdd: ((NAProductCardViewV1Model) -> Void)?
    public var onClickRemove: ((NAProductCardViewV1Model) -> Void)?
    public var onClickInitialAdd: ((NAProductCardViewV1Model) -> Void)?
    public var onClickFavourite: ((NAProductCardViewV1Model) -> Void)?
    public var onItemTap: ((NAProductCardViewV1Model) -> Void)?

    public init(
        item: Binding<NAProductCardViewV1Model>,
        onClickAdd: ((NAProductCardViewV1Model) -> Void)? = nil,
        onClickRemove: ((NAProductCardViewV1Model) -> Void)? = nil,
        onClickInitialAdd: ((NAProductCardViewV1Model) -> Void)? = nil,
        onClickFavourite: ((NAProductCardViewV1Model) -> Void)? = nil,
        onItemTap: ((NAProductCardViewV1Model) -> Void)? = nil
    ) {
        self._item = item
        self.onClickAdd = onClickAdd
        self.onClickRemove = onClickRemove
        self.onClickInitialAdd = onClickInitialAdd
        self.onClickFavourite = onClickFavourite
        self.onItemTap = onItemTap
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // MARK: - Top Image & Favorite / Stepper Overlay
            ZStack(alignment: .topTrailing) {
                Image(item.productImage, bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 12)

                Button(action: {
                    item.isFavorite.toggle()
                    onClickFavourite?(item)
                }) {
                    Image(systemName: item.isFavorite ? "heart.fill" : "heart")
                        .font(.system(size: 18))
                        .foregroundColor(.pink)
                        .padding(8)
                        .background(Color.white.opacity(0.8))
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
                .padding(4)

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        if item.quantity > 0 {
                            HStack(spacing: 8) {
                                Button(action: {
                                    item.quantity -= 1
                                    onClickRemove?(item)
                                }) {
                                    Image(systemName: "minus")
                                        .font(.system(size: 11, weight: .bold))
                                }
                                
                                Text("\(item.quantity)")
                                    .font(.system(size: 12, weight: .bold))
                                
                                Button(action: {
                                    item.quantity += 1
                                    onClickAdd?(item)
                                }) {
                                    Image(systemName: "plus")
                                        .font(.system(size: 11, weight: .bold))
                                }
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .frame(height: 32)
                            .background(Color(red: 226/255, green: 18/255, blue: 73/255))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
                        } else {
                            Button(action: {
                                item.quantity = 1
                                onClickInitialAdd?(item)
                            }) {
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
                                    .shadow(
                                        color: Color.black.opacity(0.1),
                                        radius: 3,
                                        x: 0,
                                        y: 2
                                    )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.bottom, -8)
                    .padding(.trailing, 8)
                }
            }
            .frame(height: 130)
            
            // MARK: - Product Details
            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .center, spacing: 6) {
                    Text("₹\(item.currentPrice)")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 4)
                        .background(Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    
                    Text("₹\(item.originalPrice)")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                        .strikethrough()
                }
                .padding(.top, 14)
                
                Text(item.discountText)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.green)
                
                Text(item.title)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.primary)
                    .lineLimit(3)
                    .frame(height: 54, alignment: .topLeading)
                
                Text(item.weightInfo)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                
                Text(item.flavourTag)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(
                        Color(red: 20/255, green: 90/255, blue: 110/255)
                    )
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Color(red: 230/255, green: 245/255, blue: 248/255)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                
                HStack(spacing: 3) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 10))
                        .foregroundColor(.green)
                    Text(String(format: "%.1f", item.rating))
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.primary)
                    Text(item.ratingCountText)
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
        .contentShape(Rectangle())
        .onTapGesture {
            onItemTap?(item)
        }
    }
}

// MARK: - Demo Screen
struct NAProductCardViewDemoScreen: View {
    @State private var item = NAProductCardViewV1Model(
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
    )
    
    var body: some View {
        NAProductCardViewV1(
            item: $item,
            onClickAdd: { updatedProduct in
                
            },
            onClickRemove: { updatedProduct in
                
            },
            onClickInitialAdd: { updatedProduct in
                
            },
            onClickFavourite: { updatedProduct in
                
            },
            onItemTap: { selectedProduct in
                
            }
        )
        .frame(width: 175)
    }
}

// MARK: - Preview Setup Engine
#Preview {
    NAProductCardViewDemoScreen()
}
