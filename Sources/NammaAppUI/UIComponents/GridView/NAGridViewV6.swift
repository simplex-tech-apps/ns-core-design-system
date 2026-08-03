//
//  NAGridViewV5.swift
//  NammaAppUI
//
//  Created by apple on 02/08/26.
//

import SwiftUI

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
    public var scrollDirection: Axis.Set
    public var columnCount: Int
    public var rowCount: Int
    public var spacing: CGFloat
    public var cardHeight: CGFloat
    public var cardAspectRatio: CGFloat
    public var onItemTap: ((NAGridViewV6Model) -> Void)?
    
    public init(
        items: [NAGridViewV6Model] = NAGridViewV4.defaultCategories,
        rowCount: Int = 0,
        columnCount: Int = 2,
        scrollDirection: Axis.Set = .vertical,
        spacing: CGFloat = 8,
        cardHeight: CGFloat = 140,
        cardAspectRatio: CGFloat = 135 / 140,
        onItemTap: ((NAGridViewV6Model) -> Void)? = nil
    ) {
        self.items = items
        self.rowCount = rowCount
        self.columnCount = max(1, columnCount)
        self.scrollDirection = scrollDirection
        self.spacing = spacing
        self.cardHeight = cardHeight
        self.cardAspectRatio = cardAspectRatio
        self.onItemTap = onItemTap
    }
    
    public var body: some View {
        ScrollView(scrollDirection, showsIndicators: false) {
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
    
    @ViewBuilder
    var gridContainer: some View {
        if scrollDirection == .horizontal {
            let activeRows = rowCount > 0 ? rowCount : 1
            let cardWidth = cardHeight * cardAspectRatio
            let rows = Array(repeating: GridItem(.fixed(cardHeight), spacing: spacing), count: activeRows)
            let totalGridHeight = (cardHeight * CGFloat(activeRows)) + (spacing * CGFloat(activeRows - 1))
            
            LazyHGrid(rows: rows, alignment: .top, spacing: spacing) {
                gridItems(cardWidth: cardWidth, cardHeight: cardHeight)
            }
            .frame(height: totalGridHeight)
        } else {
            let columns = Array(repeating: GridItem(.flexible(), spacing: spacing), count: columnCount)
            
            LazyVGrid(columns: columns, spacing: spacing) {
                gridItems(cardWidth: nil, cardHeight: cardHeight)
            }
        }
    }
    
    @ViewBuilder
    func gridItems(cardWidth: CGFloat?, cardHeight: CGFloat?) -> some View {
        ForEach(items) { category in
            NAGridViewV6CardView(category: category)
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
    
    public init(category: NAGridViewV6Model) {
        self.category = category
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
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(category.backgroundColor)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .strokeBorder(
                    Color.gray.opacity(0.2),
                    lineWidth: 0.75
                )
        )
    }
}

// MARK: - Default Mock Data
extension NAGridViewV4 {
    public static let defaultCategories: [NAGridViewV6Model] = [
        NAGridViewV6Model(title: "Marine/\nSea", productImageName: "fish"),
        NAGridViewV6Model(title: "Freshwater\n/Lake", productImageName: "fish"),
        NAGridViewV6Model(title: "Crab", productImageName: "fish"),
        NAGridViewV6Model(title: "Prawns/\nShell Fish", productImageName: "fish"),
        NAGridViewV6Model(title: "Exotic", productImageName: "fish"),
        NAGridViewV6Model(title: "Boneless", productImageName: "fish"),
        NAGridViewV6Model(title: "Steaks", productImageName: "fish"),
        NAGridViewV6Model(title: "Dry Fish", productImageName: "fish"),
        NAGridViewV6Model(title: "Freshly Frozen", productImageName: "fish")
    ]
}

// MARK: - Preview Setup Engine
#Preview("Vertical Grid (2 Columns)") {
    NAGridViewV6(
        rowCount: 0,
        columnCount: 3,
        scrollDirection: .vertical
    )
}

#Preview("Horizontal Grid (2 Rows)") {
    NAGridViewV6(
        rowCount: 3,
        columnCount: 0,
        scrollDirection: .horizontal
    )
}
