//
//  NAGridViewV5.swift
//  NammaAppUI
//
//  Created by apple on 02/08/26.
//

import SwiftUI

// MARK: - Card Shape Enum
public enum NACardShape {
    case rectangle
    case roundedRectangle(cornerRadius: CGFloat)
    case capsule
    
    var cornerRadius: CGFloat {
        switch self {
        case .rectangle:
            return 0
        case .roundedRectangle(let radius):
            return radius
        case .capsule:
            return 20
        }
    }
}

// MARK: - Product Model
public struct NAGridViewV6Model: Identifiable, Hashable {
    public let id: UUID
    public let title: String
    public let productImageName: String
    public let backgroundColor: Color
    
    public init(
        id: UUID = UUID(),
        title: String,
        productImageName: String,
        backgroundColor: Color = Color(red: 243/255, green: 245/255, blue: 248/255)
    ) {
        self.id = id
        self.title = title
        self.productImageName = productImageName
        self.backgroundColor = backgroundColor
    }
}

// MARK: - Dynamic Configurable Grid Component
public struct NAGridViewV6: View {
    
    public var items: [NAGridViewV6Model]
    public var orientation: NAGridOrientation
    public var gridCount: Int
    public var spacing: CGFloat
    public var cardHeight: CGFloat
    public var cardAspectRatio: CGFloat
    public var cardShape: NACardShape
    public var backgroundColor: Color?
    public var onItemTap: ((NAGridViewV6Model) -> Void)?
    
    public init(
        items: [NAGridViewV6Model] = NAGridViewV6.defaultCategories,
        orientation: NAGridOrientation = .vertical,
        gridCount: Int = 2,
        spacing: CGFloat = 8,
        cardHeight: CGFloat = 140,
        cardAspectRatio: CGFloat = 135 / 140,
        cardShape: NACardShape = .roundedRectangle(cornerRadius: 20),
        backgroundColor: Color? = nil,
        onItemTap: ((NAGridViewV6Model) -> Void)? = nil
    ) {
        self.items = items
        self.orientation = orientation
        self.gridCount = max(1, gridCount)
        self.spacing = spacing
        self.cardHeight = cardHeight
        self.cardAspectRatio = cardAspectRatio
        self.cardShape = cardShape
        self.backgroundColor = backgroundColor
        self.onItemTap = onItemTap
    }
    
    public var body: some View {
        ScrollView(scrollAxis, showsIndicators: false) {
            gridContainer
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        .background(Color(.systemBackground))
    }
}

// MARK: - Layout Calculations & Helpers
private extension NAGridViewV6 {
    
    var scrollAxis: Axis.Set {
        orientation == .horizontal ? .horizontal : .vertical
    }
    
    @ViewBuilder
    var gridContainer: some View {
        if orientation == .horizontal {
            let cardWidth = cardHeight * cardAspectRatio
            let rows = Array(repeating: GridItem(.fixed(cardHeight), spacing: spacing), count: gridCount)
            let totalGridHeight = (cardHeight * CGFloat(gridCount)) + (spacing * CGFloat(gridCount - 1))
            
            LazyHGrid(rows: rows, alignment: .top, spacing: spacing) {
                gridItems(cardWidth: cardWidth, cardHeight: cardHeight)
            }
            .frame(height: totalGridHeight)
        } else {
            let columns = Array(repeating: GridItem(.flexible(), spacing: spacing), count: gridCount)
            
            LazyVGrid(columns: columns, spacing: spacing) {
                gridItems(cardWidth: nil, cardHeight: cardHeight)
            }
        }
    }
    
    @ViewBuilder
    func gridItems(cardWidth: CGFloat?, cardHeight: CGFloat?) -> some View {
        ForEach(items) { category in
            NAGridViewV6CardView(
                category: category,
                cardShape: cardShape,
                overrideBackgroundColor: backgroundColor
            )
            .frame(width: cardWidth, height: cardHeight)
            .contentShape(Rectangle())
            .onTapGesture {
                onItemTap?(category)
            }
        }
    }
}

// MARK: - Individual Fresh Card View
public struct NAGridViewV6CardView: View {
    public let category: NAGridViewV6Model
    public var cardShape: NACardShape
    public var overrideBackgroundColor: Color?
    
    public init(
        category: NAGridViewV6Model,
        cardShape: NACardShape = .roundedRectangle(cornerRadius: 20),
        overrideBackgroundColor: Color? = nil
    ) {
        self.category = category
        self.cardShape = cardShape
        self.overrideBackgroundColor = overrideBackgroundColor
    }
    
    private var effectiveBackgroundColor: Color {
        overrideBackgroundColor ?? category.backgroundColor
    }
    
    public var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading, spacing: 0) {
                Text(category.title)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(Color(red: 44/255, green: 53/255, blue: 71/255))
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .minimumScaleFactor(0.85)
                
                Spacer()
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .padding(.top, 14)
            .padding(.horizontal, 12)
            
            Image(category.productImageName, bundle: .module)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 85)
                .padding(.bottom, 0)
                .padding(.trailing, 0)
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: cardShape.cornerRadius, style: .continuous)
                .fill(effectiveBackgroundColor)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: cardShape.cornerRadius, style: .continuous)
        )
        .overlay(
            RoundedRectangle(cornerRadius: cardShape.cornerRadius, style: .continuous)
                .strokeBorder(
                    Color.gray.opacity(0.2),
                    lineWidth: 0.75
                )
        )
    }
}

// MARK: - Default Mock Data
extension NAGridViewV6 {
    public static let defaultCategories: [NAGridViewV6Model] = [
        NAGridViewV6Model(
            title: "Chicken & Poultry",
            productImageName: "fish"
        ),
        NAGridViewV6Model(
            title: "Fresh Mutton",
            productImageName: "fish"
        ),
        NAGridViewV6Model(
            title: "Fish & Seafood",
            productImageName: "fish"
        ),
        NAGridViewV6Model(
            title: "Eggs & Special Cuts",
            productImageName: "fish"
        )
    ]
}

// MARK: - Usage Example
struct NAGridViewV6DemoScreen: View {
    var body: some View {
        NAGridViewV6(
            items: NAGridViewV6.defaultCategories,
            orientation: .vertical,
            gridCount: 3,
            spacing: 10,
            cardShape: .capsule,
            backgroundColor: Color(red: 232/255, green: 245/255, blue: 233/255)
        ) { selectedCategory in
        
        }
    }
}

#Preview {
    NAGridViewV6DemoScreen()
}
