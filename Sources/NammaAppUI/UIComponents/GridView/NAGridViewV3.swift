//
//  NAGridViewV3.swift
//  NammaAppUI
//
//  Created by apple on 02/08/26.
//

import SwiftUI

// MARK: - Product Model
public struct NAGridViewV3Model: Identifiable, Equatable {
    public let id: UUID
    public var name: String
    public var images: [String]
    public var currentPrice: Int
    public var originalPrice: Int
    public var quantity: Int
    public var isFavorite: Bool
    
    public init(
        id: UUID = UUID(),
        name: String,
        images: [String],
        currentPrice: Int = 180,
        originalPrice: Int = 200,
        quantity: Int = 0,
        isFavorite: Bool = false
    ) {
        self.id = id
        self.name = name
        self.images = images
        self.currentPrice = currentPrice
        self.originalPrice = originalPrice
        self.quantity = quantity
        self.isFavorite = isFavorite
    }
}

// MARK: - Grid Orientation Enum
public enum NAGridOrientation {
    case horizontal
    case vertical
}

// MARK: - Dynamic Configurable Grid Component
public struct NAGridViewV3: View {
    
    @Binding public var items: [NAGridViewV3Model]
    public var orientation: NAGridOrientation
    public var gridCount: Int
    public var spacing: CGFloat
    public var cardAspectRatio: CGFloat
    public var baseCardHeight: CGFloat
    public var backgroundColor: Color

    public var onClickAdd: ((NAGridViewV3Model) -> Void)?
    public var onClickRemove: ((NAGridViewV3Model) -> Void)?
    public var onClickInitialAdd: ((NAGridViewV3Model) -> Void)?
    public var onClickFavourite: ((NAGridViewV3Model) -> Void)?
    public var onItemTap: ((NAGridViewV3Model) -> Void)?
    
    public init(
        items: Binding<[NAGridViewV3Model]>,
        orientation: NAGridOrientation = .vertical,
        gridCount: Int = 2,
        spacing: CGFloat = 10,
        cardAspectRatio: CGFloat = 135 / 140,
        baseCardHeight: CGFloat = 135,
        backgroundColor: Color = Color.green.opacity(0.08),
        onClickAdd: ((NAGridViewV3Model) -> Void)? = nil,
        onClickRemove: ((NAGridViewV3Model) -> Void)? = nil,
        onClickInitialAdd: ((NAGridViewV3Model) -> Void)? = nil,
        onClickFavourite: ((NAGridViewV3Model) -> Void)? = nil,
        onItemTap: ((NAGridViewV3Model) -> Void)? = nil
    ) {
        self._items = items
        self.orientation = orientation
        self.gridCount = max(1, gridCount)
        self.spacing = spacing
        self.cardAspectRatio = cardAspectRatio
        self.baseCardHeight = baseCardHeight
        self.backgroundColor = backgroundColor
        self.onClickAdd = onClickAdd
        self.onClickRemove = onClickRemove
        self.onClickInitialAdd = onClickInitialAdd
        self.onClickFavourite = onClickFavourite
        self.onItemTap = onItemTap
    }

    public var body: some View {
        ScrollView(scrollAxis, showsIndicators: false) {
            gridContainer
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
        }
    }
}

// MARK: - Dynamic Layout Calculations
private extension NAGridViewV3 {
    
    var scrollAxis: Axis.Set {
        orientation == .horizontal ? .horizontal : .vertical
    }
    
    @ViewBuilder
    var gridContainer: some View {
        if orientation == .horizontal {
            let cardWidth = baseCardHeight * cardAspectRatio
            let rows = Array(repeating: GridItem(.fixed(baseCardHeight), spacing: spacing), count: gridCount)
            
            LazyHGrid(rows: rows, spacing: spacing) {
                ForEach($items) { $item in
                    NAGridViewV3CardView(
                        item: $item,
                        cardBackgroundColor: backgroundColor,
                        onClickAdd: { onClickAdd?(item) },
                        onClickRemove: { onClickRemove?(item) },
                        onClickInitialAdd: { onClickInitialAdd?(item) },
                        onClickFavourite: { onClickFavourite?(item) }
                    )
                    .frame(width: cardWidth, height: baseCardHeight)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        onItemTap?(item)
                    }
                }
            }
        } else {
            let columns = Array(repeating: GridItem(.flexible(), spacing: spacing), count: gridCount)
            
            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach($items) { $item in
                    NAGridViewV3CardView(
                        item: $item,
                        cardBackgroundColor: backgroundColor,
                        onClickAdd: { onClickAdd?(item) },
                        onClickRemove: { onClickRemove?(item) },
                        onClickInitialAdd: { onClickInitialAdd?(item) },
                        onClickFavourite: { onClickFavourite?(item) }
                    )
                    .aspectRatio(cardAspectRatio, contentMode: .fit)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        onItemTap?(item)
                    }
                }
            }
        }
    }
}

// MARK: - Dynamic Card View Component
public struct NAGridViewV3CardView: View {
    @Binding public var item: NAGridViewV3Model
    public var cardBackgroundColor: Color
    
    public var onClickAdd: () -> Void
    public var onClickRemove: () -> Void
    public var onClickInitialAdd: () -> Void
    public var onClickFavourite: () -> Void
    
    public init(
        item: Binding<NAGridViewV3Model>,
        cardBackgroundColor: Color = Color.green.opacity(0.08),
        onClickAdd: @escaping () -> Void = {},
        onClickRemove: @escaping () -> Void = {},
        onClickInitialAdd: @escaping () -> Void = {},
        onClickFavourite: @escaping () -> Void = {}
    ) {
        self._item = item
        self.cardBackgroundColor = cardBackgroundColor
        self.onClickAdd = onClickAdd
        self.onClickRemove = onClickRemove
        self.onClickInitialAdd = onClickInitialAdd
        self.onClickFavourite = onClickFavourite
    }
    
    public var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            
            let fontSize = max(10, min(12, width * 0.08))
            let imageThumbHeight = max(32, height * 0.35)
            
            VStack(spacing: 0) {
                HStack(alignment: .top, spacing: 4) {
                    Text(item.name)
                        .font(.system(size: fontSize, weight: .semibold, design: .rounded))
                        .foregroundColor(Color(red: 50/255, green: 50/255, blue: 50/255))
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    
                    Spacer(minLength: 2)
                    
                    Button(action: {
                        item.isFavorite.toggle()
                        onClickFavourite()
                    }) {
                        Image(systemName: item.isFavorite ? "heart.fill" : "heart")
                            .font(.system(size: fontSize * 0.9, weight: .bold))
                            .foregroundColor(.pink)
                            .frame(width: max(20, width * 0.16), height: max(20, width * 0.16))
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.06), radius: 2, x: 0, y: 1)
                    }
                }
                .padding(.horizontal, width * 0.07)
                .padding(.top, height * 0.07)
                
                Spacer(minLength: 0)

                HStack(spacing: width * 0.04) {
                    ForEach(item.images.prefix(2), id: \.self) { imageKey in
                        ZStack {
                            Color.white
                            Image("chicken_product", bundle: .module)
                                .resizable()
                                .scaledToFit()
                                .padding(4)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: imageThumbHeight)
                        .cornerRadius(width * 0.08)
                        .shadow(color: Color.black.opacity(0.04), radius: 2, x: 0, y: 1)
                    }
                }
                .padding(.horizontal, width * 0.06)
                
                Spacer(minLength: 0)

                HStack {
                    Spacer()
                    if item.quantity > 0 {
                        HStack(spacing: 8) {
                            Button(action: { item.quantity -= 1 }) {
                                Image(systemName: "minus")
                                    .font(.system(size: 10, weight: .bold))
                            }
                            
                            Text("\(item.quantity)")
                                .font(.system(size: 11, weight: .bold))
                            
                            Button(action: { item.quantity += 1 }) {
                                Image(systemName: "plus")
                                    .font(.system(size: 10, weight: .bold))
                            }
                        }
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color(red: 226/255, green: 18/255, blue: 73/255))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                    } else {
                        Button(action: { item.quantity = 1 }) {
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
                    }
                }
                .padding(.horizontal, width * 0.06)
                .padding(.bottom, height * 0.06)
            }
            .frame(width: width, height: height)
            .background(
                RoundedRectangle(cornerRadius: width * 0.10, style: .continuous)
                    .fill(cardBackgroundColor)
            )
        }
    }
}

// MARK: - Demo Usage
struct NAGridViewV3DemoScreen: View {
    @State private var items = [
        NAGridViewV3Model(name: "Premium Goat + Chicken Combo", images: ["img1", "img2"], currentPrice: 280, quantity: 1),
        NAGridViewV3Model(name: "Fresh Seafood Special Platter", images: ["img1", "img2"], currentPrice: 340, quantity: 0),
        NAGridViewV3Model(name: "Curry Cut Mutton Family Pack", images: ["img1", "img2"], currentPrice: 450, quantity: 0),
        NAGridViewV3Model(name: "Boneless Breast + Wings", images: ["img1", "img2"], currentPrice: 220, quantity: 0)
    ]
    
    var body: some View {
        NAGridViewV3(
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
    NAGridViewV3DemoScreen()
}
