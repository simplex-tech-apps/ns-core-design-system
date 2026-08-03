//
//  NAGridViewV5.swift
//  NammaAppUI
//
//  Created by apple on 02/08/26.
//

import SwiftUI

// MARK: - Product Model
public struct NAGridViewV7Model: Identifiable, Hashable {
    public let id: UUID
    public let title: String
    public let imageName: String
    public let backgroundColor: Color
    
    public init(
        id: UUID = UUID(),
        title: String,
        imageName: String,
        backgroundColor: Color = Color(red: 219/255, green: 233/255, blue: 252/255)
    ) {
        self.id = id
        self.title = title
        self.imageName = imageName
        self.backgroundColor = backgroundColor
    }
}

// MARK: - Dynamic Configurable Grid Component
public struct NAGridViewV7: View {
    
    public var items: [NAGridViewV7Model]
    public var scrollDirection: Axis.Set
    public var columnCount: Int
    public var rowCount: Int
    public var spacing: CGFloat
    public var cardHeight: CGFloat
    public var cardAspectRatio: CGFloat
    public var onItemTap: ((NAGridViewV7Model) -> Void)?
    
    public init(
        items: [NAGridViewV7Model] = NAGridViewV7.defaultCategories,
        rowCount: Int = 0,
        columnCount: Int = 2,
        scrollDirection: Axis.Set = .vertical,
        spacing: CGFloat = 12,
        cardHeight: CGFloat = 120,
        cardAspectRatio: CGFloat = 160 / 120,
        onItemTap: ((NAGridViewV7Model) -> Void)? = nil
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
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 8)
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        .background(Color(.systemBackground))
    }
}

// MARK: - Layout Calculations & Helpers
private extension NAGridViewV7 {
    
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
            NAGridViewV7CardView(category: category)
                .frame(width: cardWidth, height: cardHeight)
                .contentShape(Rectangle())
                .onTapGesture {
                    onItemTap?(category)
                }
        }
    }
}

// MARK: - Individual Fresh Card View
public struct NAGridViewV7CardView: View {
    public let category: NAGridViewV7Model
    
    public init(category: NAGridViewV7Model) {
        self.category = category
    }
    
    public var body: some View {
        ZStack(alignment: .bottomTrailing) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(category.title)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(
                            Color(red: 33/255, green: 43/255, blue: 54/255)
                        )
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .frame(
                            height: 48,
                            alignment: .topLeading
                        )
                    
                    Spacer(minLength: 12)
                    
                    Image(systemName: "arrow.right")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black)
                        .frame(width: 30, height: 30)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(
                            color: Color.black.opacity(0.05),
                            radius: 2,
                            x: 0,
                            y: 1
                        )
                }
                .padding(.vertical, 16)
                .padding(.leading, 16)
                
                Spacer()
            }
            
            Image(category.imageName, bundle: .module)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 120)
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(category.backgroundColor)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
        )
    }
}

// MARK: - Default Mock Data
extension NAGridViewV7 {
    public static let defaultCategories: [NAGridViewV7Model] = [
        NAGridViewV7Model(title: "All", imageName: "fish"),
        NAGridViewV7Model(title: "Premium Chicken", imageName: "fish"),
        NAGridViewV7Model(title: "Country Chicken", imageName: "fish"),
        NAGridViewV7Model(title: "Boneless", imageName: "fish"),
        NAGridViewV7Model(title: "Duck", imageName: "fish"),
        NAGridViewV7Model(title: "Quail", imageName: "fish")
    ]
}

// MARK: - Preview Setup Engine
#Preview("Vertical Grid (2 Columns)") {
    NAGridViewV7(
        rowCount: 0,
        columnCount: 2,
        scrollDirection: .vertical
    )
}

#Preview("Horizontal Grid (2 Rows)") {
    NAGridViewV7(
        rowCount: 2,
        columnCount: 0,
        scrollDirection: .horizontal
    )
}
