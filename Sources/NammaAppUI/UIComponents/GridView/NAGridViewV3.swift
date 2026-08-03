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
    public let name: String
    public let images: [String]
    public let backgroundColor: Color
    
    public init(
        id: UUID = UUID(),
        name: String,
        images: [String],
        backgroundColor: Color = Color(red: 254/255, green: 224/255, blue: 195/255)
    ) {
        self.id = id
        self.name = name
        self.images = images
        self.backgroundColor = backgroundColor
    }
}

// MARK: - Grid Orientation Enum
public enum NAGridOrientation {
    case horizontal
    case vertical
}

// MARK: - Dynamic Configurable Grid Component
public struct NAGridViewV3: View {
    
    public var items: [NAGridViewV3Model]
    public var orientation: NAGridOrientation
    public var gridCount: Int
    public var spacing: CGFloat
    public var cardAspectRatio: CGFloat
    public var baseCardHeight: CGFloat
    
    public var onItemTap: ((NAGridViewV3Model) -> Void)?
    
    public init(
        items: [NAGridViewV3Model],
        orientation: NAGridOrientation = .horizontal,
        gridCount: Int = 1,
        spacing: CGFloat = 14,
        cardAspectRatio: CGFloat = 135 / 140,
        baseCardHeight: CGFloat = 135,
        onItemTap: ((NAGridViewV3Model) -> Void)? = nil
    ) {
        self.items = items
        self.orientation = orientation
        self.gridCount = max(1, gridCount)
        self.spacing = spacing
        self.cardAspectRatio = cardAspectRatio
        self.baseCardHeight = baseCardHeight
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
                ForEach(items) { item in
                    NAGridViewV3CardView(item: item)
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
                ForEach(items) { item in
                    NAGridViewV3CardView(item: item)
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
    public let item: NAGridViewV3Model
    
    public init(item: NAGridViewV3Model) {
        self.item = item
    }
    
    public var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            
            let fontSize = max(10, min(14, width * 0.08))
            let arrowSize = max(18, min(28, width * 0.18))
            let imageThumbHeight = max(32, height * 0.35)
            
            VStack(spacing: 0) {
                HStack(alignment: .top, spacing: 4) {
                    Text(item.name)
                        .font(.system(size: fontSize, weight: .semibold, design: .rounded))
                        .foregroundColor(Color(red: 50/255, green: 50/255, blue: 50/255))
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    
                    Spacer(minLength: 2)
                    
                    Image(systemName: "arrow.right")
                        .font(.system(size: fontSize * 0.85, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: arrowSize, height: arrowSize)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(
                            color: Color.black.opacity(0.06),
                            radius: 2,
                            x: 0,
                            y: 1
                        )
                }
                .padding(.horizontal, width * 0.07)
                .padding(.top, height * 0.07)
                
                Spacer(minLength: 0)

                HStack(spacing: width * 0.04) {
                    ForEach(item.images.prefix(2), id: \.self) { _ in
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
                        .shadow(
                            color: Color.black.opacity(0.04),
                            radius: 2,
                            x: 0,
                            y: 1
                        )
                    }
                }
                .padding(.horizontal, width * 0.06)
                .padding(.bottom, height * 0.07)
            }
            .frame(width: width, height: height)
            .background(
                RoundedRectangle(cornerRadius: width * 0.14, style: .continuous)
                    .fill(item.backgroundColor)
            )
        }
    }
}

// MARK: - Previews
#Preview("Horizontal 2-Row Grid (Cells maintain size)") {
    let mockData = [
        NAGridViewV3Model(name: "Premium Goat + Chicken Combo", images: ["img1", "img2"]),
        NAGridViewV3Model(name: "Fresh Seafood Special Platter", images: ["img1", "img2"]),
        NAGridViewV3Model(name: "Curry Cut Mutton Family Pack", images: ["img1", "img2"]),
        NAGridViewV3Model(name: "Boneless Breast + Wings", images: ["img1", "img2"]),
    ]
    
    return NAGridViewV3(
        items: mockData,
        orientation: .horizontal,
        gridCount: 1,
        baseCardHeight: 135
    )
}

#Preview("Dynamic Vertical Grid") {
    let mockData = [
        NAGridViewV3Model(name: "Premium Goat + Chicken Combo", images: ["img1", "img2"]),
        NAGridViewV3Model(name: "Fresh Seafood Special Platter", images: ["img1", "img2"]),
        NAGridViewV3Model(name: "Curry Cut Mutton Family Pack", images: ["img1", "img2"]),
        NAGridViewV3Model(name: "Boneless Breast + Wings", images: ["img1", "img2"])
    ]
    
    return NAGridViewV3(
        items: mockData,
        orientation: .vertical,
        gridCount: 3,
        spacing: 10
    )
}
