//
//  NAGridViewV2.swift
//  NammaAppUI
//
//  Created by apple on 31/07/26.
//

import SwiftUI

// MARK: - Product Data Model
public struct NAGridViewV2Model: Identifiable {
    public let id = UUID()
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

// MARK: - Main Configurable Grid View
public struct NAGridViewV2: View {
    @Binding public var items: [NAGridViewV2Model]
    public let orientation: GridOrientation
    public let gridCount: Int
    public let spacing: CGFloat
    public let backgroundColor: Color
    public var onClickAdd: ((NAGridViewV2Model) -> Void)?
    public var onClickRemove: ((NAGridViewV2Model) -> Void)?
    public var onClickInitialAdd: ((NAGridViewV2Model) -> Void)?
    public var onClickFavourite: ((NAGridViewV2Model) -> Void)?
    public var onItemTap: ((NAGridViewV2Model) -> Void)?
    
    public init(
        items: Binding<[NAGridViewV2Model]>,
        orientation: GridOrientation = .horizontal,
        gridCount: Int = 1,
        spacing: CGFloat = 12,
        backgroundColor: Color,
        onClickAdd: ((NAGridViewV2Model) -> Void)? = nil,
        onClickRemove: ((NAGridViewV2Model) -> Void)? = nil,
        onClickInitialAdd: ((NAGridViewV2Model) -> Void)? = nil,
        onClickFavourite: ((NAGridViewV2Model) -> Void)? = nil,
        onItemTap: ((NAGridViewV2Model) -> Void)? = nil
    ) {
        self._items = items
        self.orientation = orientation
        self.gridCount = gridCount
        self.spacing = spacing
        self.backgroundColor = backgroundColor
        self.onClickAdd = onClickAdd
        self.onClickRemove = onClickRemove
        self.onClickInitialAdd = onClickInitialAdd
        self.onClickFavourite = onClickFavourite
        self.onItemTap = onItemTap
    }
    
    private func calculatedCardWidth(containerWidth: CGFloat) -> CGFloat {
        switch orientation {
        case .vertical:
            let totalPadding = spacing * CGFloat(gridCount + 1)
            let availableWidth = containerWidth - totalPadding
            return max(80, availableWidth / CGFloat(max(1, gridCount)))
            
        case .horizontal:
            return max(140, containerWidth * 0.40)
        }
    }
    
    private func gridItems(calculatedWidth: CGFloat) -> [GridItem] {
        switch orientation {
        case .vertical:
            return Array(repeating: GridItem(.flexible(minimum: calculatedWidth), spacing: spacing), count: max(1, gridCount))
        case .horizontal:
            let estimatedTotalCardHeight = calculatedWidth + 180
            return Array(repeating: GridItem(.fixed(estimatedTotalCardHeight), spacing: spacing), count: max(1, gridCount))
        }
    }
    
    public var body: some View {
        GeometryReader { geometry in
            let dynamicWidth = calculatedCardWidth(containerWidth: geometry.size.width)
            
            Group {
                switch orientation {
                case .vertical:
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: gridItems(calculatedWidth: dynamicWidth), alignment: .leading, spacing: spacing) {
                            ForEach($items) { $product in
                                NAGridViewV2CardView(product: $product, orientation: orientation, backgroundColor: backgroundColor, cardWidth: dynamicWidth)
                            }
                        }
                        .padding(.horizontal, spacing)
                    }
                    
                case .horizontal:
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: gridItems(calculatedWidth: dynamicWidth), alignment: .top, spacing: spacing) {
                            ForEach($items) { $product in
                                NAGridViewV2CardView(product: $product, orientation: orientation, backgroundColor: backgroundColor, cardWidth: dynamicWidth)
                                    .frame(width: dynamicWidth)
                            }
                        }
                        .padding(.horizontal, spacing)
                    }
                }
            }
        }
    }
}

// MARK: - Dynamic Product Card Component View
public struct NAGridViewV2CardView: View {
    @Binding public var product: NAGridViewV2Model
    public var orientation: GridOrientation = .horizontal
    public var backgroundColor: Color
    public var cardWidth: CGFloat?
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack {
                Image(product.productImage, bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .padding(12)

                VStack {
                    HStack {
                        Spacer()
                        Button(action: { product.isFavorite.toggle() }) {
                            Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.pink)
                                .padding(6)
                                .background(Color.white.opacity(0.8))
                                .clipShape(Circle())
                        }
                        .padding(6)
                    }
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        if product.quantity > 0 {
                            HStack(spacing: 8) {
                                Button(action: { product.quantity -= 1 }) {
                                    Image(systemName: "minus")
                                        .font(.system(size: 10, weight: .bold))
                                }
                                
                                Text("\(product.quantity)")
                                    .font(.system(size: 11, weight: .bold))
                                
                                Button(action: { product.quantity += 1 }) {
                                    Image(systemName: "plus")
                                        .font(.system(size: 10, weight: .bold))
                                }
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 8)
                            .background(Color(red: 226/255, green: 18/255, blue: 73/255))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .padding(6)
                            
                        } else {
                            Button(action: { product.quantity = 1 }) {
                                VStack(spacing: 1) {
                                    Text("ADD")
                                        .font(.system(size: 11, weight: .bold))
                                        .foregroundColor(.pink)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .strokeBorder(Color.pink, lineWidth: 1.5)
                                )
                                .shadow(color: Color.black.opacity(0.08), radius: 2, x: 0, y: 1)
                            }
                            .padding(6)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: cardWidth ?? 140)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 14))

            HStack(alignment: .center, spacing: 6) {
                Text("₹\(product.currentPrice)")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color(red: 16/255, green: 110/255, blue: 43/255))
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                
                Text("₹\(product.originalPrice)")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .strikethrough()
            }
            .padding(.top, 4)
            
            Text(product.discountText)
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(Color(red: 16/255, green: 110/255, blue: 43/255))
            
            Text(product.title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.black.opacity(0.85))
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(product.volumeInfo)
                .font(.system(size: 11))
                .foregroundColor(.secondary)
            
            Text(product.finishTag)
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(Color(red: 20/255, green: 110/255, blue: 130/255))
                .padding(.horizontal, 6)
                .padding(.vertical, 3)
                .background(Color(red: 232/255, green: 247/255, blue: 250/255))
                .clipShape(RoundedRectangle(cornerRadius: 4))
            
            HStack(spacing: 3) {
                Image(systemName: "star.fill")
                    .font(.system(size: 9))
                    .foregroundColor(Color(red: 16/255, green: 110/255, blue: 43/255))
                
                Text(String(format: "%.1f", product.rating))
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.black)
                
                Text(product.ratingCountText)
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
            .padding(.top, 1)

            if let promo = product.promotionText {
                Button(action: {}) {
                    HStack(spacing: 2) {
                        Text(promo)
                            .font(.system(size: 10, weight: .bold))
                        Image(systemName: "chevron.right")
                            .font(.system(size: 7, weight: .bold))
                    }
                    .foregroundColor(.blue)
                }
                .padding(.top, 2)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        
    }
}
// MARK: - Demo Screen
struct NAGridViewV2DemoScreen: View {
    @State private var items = [
        NAGridViewV2Model(
            title: "Blue Heaven Intense Matte Lipstick | Plum Desire 05",
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
        NAGridViewV2Model(
            title: "Lakme Forever Matte Liquid Lip, 16hr Lipstick, Light weight",
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
        NAGridViewV2Model(
            title: "Lakme Forever Matte Liquid Lip, 16hr Lipstick, Light weight",
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
        )
    ]
    
    var body: some View {
        NAGridViewV2(
            items: $items,
            orientation: .vertical,
            gridCount: 2,
            spacing: 10,
            backgroundColor: Color.green.opacity(0.08),
            onClickAdd: { item in
                
            },
            onClickRemove: { item in
               
            },
            onClickInitialAdd: { item in
               
            },
            onClickFavourite: { item in
               
            }
        ) { selectedItem in
            
        }
    }
}

#Preview {
    NAGridViewV2DemoScreen()
}
