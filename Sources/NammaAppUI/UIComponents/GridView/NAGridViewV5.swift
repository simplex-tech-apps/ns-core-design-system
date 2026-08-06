//
//  NAGridViewV5.swift
//  NammaAppUI
//
//  Created by apple on 02/08/26.
//

import SwiftUI

// MARK: - Product Model
public struct NAGridViewV5Model: Identifiable, Equatable {
    public let id: UUID
    public let title: String
    public let productImage: String
    
    public init(id: UUID = UUID(), title: String, productImage: String) {
        self.id = id
        self.title = title
        self.productImage = productImage
    }
}

// MARK: - Expanded Card Shape Style Enum
public enum NAGridCardShape {
    case square
    case rectangle
    case verticalRectangle
    case horizontalRectangle

    var defaultCardAspectRatio: CGFloat {
        switch self {
        case .square:
            return 1.0
        case .rectangle, .verticalRectangle:
            return 0.72
        case .horizontalRectangle:
            return 1.35
        }
    }
    
    var imageBoxAspectRatio: CGFloat {
        switch self {
        case .square:
            return 1.0
        case .rectangle, .verticalRectangle:
            return 0.85
        case .horizontalRectangle:
            return 1.75
        }
    }
}

// MARK: - Dynamic Grid View
public struct NAGridViewV5: View {
    
    public var items: [NAGridViewV5Model]
    public var orientation: NAGridOrientation
    public var gridCount: Int
    public var spacing: CGFloat
    public var cardShape: NAGridCardShape
    public var backgroundColor: Color
    public var baseCardHeight: CGFloat
    public var onItemTap: ((NAGridViewV5Model) -> Void)?
    
    public var cardAspectRatio: CGFloat {
        cardShape.defaultCardAspectRatio
    }
    
    public init(
        items: [NAGridViewV5Model] = NAGridViewV5.defaultCategories,
        orientation: NAGridOrientation = .vertical,
        gridCount: Int = 4,
        spacing: CGFloat = 10,
        cardShape: NAGridCardShape = .rectangle,
        backgroundColor: Color = Color(red: 238/255, green: 244/255, blue: 252/255),
        baseCardHeight: CGFloat = 130,
        onItemTap: ((NAGridViewV5Model) -> Void)? = nil
    ) {
        self.items = items
        self.orientation = orientation
        self.gridCount = max(1, gridCount)
        self.spacing = spacing
        self.cardShape = cardShape
        self.backgroundColor = backgroundColor
        self.baseCardHeight = baseCardHeight
        self.onItemTap = onItemTap
    }
    
    public var body: some View {
        ScrollView(scrollAxis, showsIndicators: false) {
            gridContainer
                .padding(.horizontal, spacing == 0 ? 0 : 12)
                .padding(.vertical, spacing == 0 ? 0 : 8)
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
    }
}

// MARK: - Layout Calculations & Helpers
private extension NAGridViewV5 {
    
    var scrollAxis: Axis.Set {
        orientation == .horizontal ? .horizontal : .vertical
    }
    
    @ViewBuilder
    var gridContainer: some View {
        if orientation == .horizontal {
            let cardWidth = baseCardHeight * cardAspectRatio
            let calculatedHeight = (cardWidth / cardShape.imageBoxAspectRatio) + 28
            let rows = Array(repeating: GridItem(.fixed(calculatedHeight), spacing: spacing), count: gridCount)
            let totalGridHeight = (calculatedHeight * CGFloat(gridCount)) + (spacing * CGFloat(gridCount - 1))
            
            LazyHGrid(rows: rows, alignment: .top, spacing: spacing) {
                gridItems(cardWidth: cardWidth, cardHeight: calculatedHeight)
            }
            .frame(height: totalGridHeight)
        } else {
            let columns = Array(repeating: GridItem(.flexible(), spacing: spacing), count: gridCount)
            
            LazyVGrid(columns: columns, spacing: spacing) {
                gridItems(cardWidth: nil, cardHeight: nil)
            }
        }
    }
    
    @ViewBuilder
    func gridItems(cardWidth: CGFloat?, cardHeight: CGFloat?) -> some View {
        ForEach(items) { category in
            NAGridViewV5CardView(
                category: category,
                cardShape: cardShape,
                backgroundColor: backgroundColor,
                isHorizontal: orientation == .horizontal
            )
            .frame(width: cardWidth, height: cardHeight)
            .contentShape(Rectangle())
            .onTapGesture {
                onItemTap?(category)
            }
        }
    }
}

// MARK: - Card Component (Title Overlap Fixed)
public struct NAGridViewV5CardView: View {
    public let category: NAGridViewV5Model
    public var cardShape: NAGridCardShape
    public var backgroundColor: Color
    public var isHorizontal: Bool
    
    public init(
        category: NAGridViewV5Model,
        cardShape: NAGridCardShape = .rectangle,
        backgroundColor: Color = Color(red: 238/255, green: 244/255, blue: 252/255),
        isHorizontal: Bool = false
    ) {
        self.category = category
        self.cardShape = cardShape
        self.backgroundColor = backgroundColor
        self.isHorizontal = isHorizontal
    }
    
    public var body: some View {
        if isHorizontal {
            GeometryReader { geo in
                let imageContainerHeight = geo.size.width / cardShape.imageBoxAspectRatio
                cardContent(containerWidth: geo.size.width, imageContainerHeight: imageContainerHeight)
            }
            .clipped()
        } else {
            VStack(spacing: 0) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(backgroundColor)
                    
                    Image(category.productImage, bundle: .module)
                        .resizable()
                        .scaledToFit()
                        .padding(4)
                }
                .aspectRatio(cardShape.imageBoxAspectRatio, contentMode: .fit)
                
                Text(category.title)
                    .font(.system(size: 10, weight: .semibold, design: .default))
                    .foregroundColor(Color(red: 44/255, green: 53/255, blue: 71/255))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .frame(height: 28)
            }
        }
    }
    
    @ViewBuilder
    private func cardContent(containerWidth: CGFloat, imageContainerHeight: CGFloat) -> some View {
        VStack(spacing: 0) {
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(backgroundColor)
                
                Image(category.productImage, bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .padding(4)
            }
            .frame(width: containerWidth, height: imageContainerHeight)
            
            Text(category.title)
                .font(.system(size: 10, weight: .semibold, design: .default))
                .foregroundColor(Color(red: 44/255, green: 53/255, blue: 71/255))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
                .frame(width: containerWidth, height: 28, alignment: .center)
        }
    }
}

// MARK: - Default Mock Data
extension NAGridViewV5 {
    public static let defaultCategories: [NAGridViewV5Model] = [
        NAGridViewV5Model(title: "Cough, Cold\n& Fever", productImage: "chicken_product"),
        NAGridViewV5Model(title: "Vitamin &\nSupplements", productImage: "chicken_product"),
        NAGridViewV5Model(title: "Pain\nRelief", productImage: "chicken_product"),
        NAGridViewV5Model(title: "Elderly\nCare", productImage: "chicken_product"),
        NAGridViewV5Model(title: "Ayurveda &\nImmunity", productImage: "chicken_product"),
        NAGridViewV5Model(title: "Stomach\nCare", productImage: "chicken_product"),
        NAGridViewV5Model(title: "Derma\nCare", productImage: "chicken_product"),
        NAGridViewV5Model(title: "Medical\nDevices", productImage: "chicken_product")
    ]
}

// MARK: - All Preview Variations (Corrected)
#Preview("Vertical Grid (Vertical Rectangle)") {
    NAGridViewV5(
        items: NAGridViewV5.defaultCategories,
        orientation: .vertical,
        gridCount: 4,
        spacing: 10,
        cardShape: .verticalRectangle,
        backgroundColor: Color(red: 238/255, green: 244/255, blue: 252/255)
    )
}

#Preview("Vertical Grid (Horizontal Rectangle)") {
    NAGridViewV5(
        items: NAGridViewV5.defaultCategories,
        orientation: .vertical,
        gridCount: 2,
        spacing: 10,
        cardShape: .horizontalRectangle,
        backgroundColor: Color(red: 238/255, green: 244/255, blue: 252/255)
    )
}

#Preview("Horizontal Grid (Horizontal Rectangle)") {
    NAGridViewV5(
        items: NAGridViewV5.defaultCategories,
        orientation: .horizontal,
        gridCount: 2,
        spacing: 10,
        cardShape: .horizontalRectangle,
        backgroundColor: Color(red: 232/255, green: 245/255, blue: 233/255)
    )
}

#Preview("Horizontal Grid (Vertical Rectangle)") {
    NAGridViewV5(
        items: NAGridViewV5.defaultCategories,
        orientation: .horizontal,
        gridCount: 2,
        spacing: 10,
        cardShape: .verticalRectangle,
        backgroundColor: Color(red: 232/255, green: 245/255, blue: 233/255)
    )
}

#Preview("Vertical Grid (Square Cells)") {
    NAGridViewV5(
        items: NAGridViewV5.defaultCategories,
        orientation: .vertical,
        gridCount: 3,
        spacing: 10,
        cardShape: .square,
        backgroundColor: Color(red: 218/255, green: 247/255, blue: 194/255)
    )
}

#Preview("Horizontal Grid (Square Cells)") {
    NAGridViewV5(
        items: NAGridViewV5.defaultCategories,
        orientation: .horizontal,
        gridCount: 1,
        spacing: 10,
        cardShape: .square,
        backgroundColor: Color(red: 232/255, green: 245/255, blue: 233/255)
    ) { selectedCategory in
        print("Selected category: \(selectedCategory.title)")
    }
}
