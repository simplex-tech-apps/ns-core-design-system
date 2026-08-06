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
    public var orientation: NAGridOrientation
    public var gridCount: Int
    public var spacing: CGFloat
    public var cardHeight: CGFloat
    public var cardAspectRatio: CGFloat
    public var cardShape: NACardShape
    public var backgroundColor: Color?
    public var onItemTap: ((NAGridViewV7Model) -> Void)?
    
    public init(
        items: [NAGridViewV7Model] = NAGridViewV7.defaultCategories,
        orientation: NAGridOrientation = .vertical,
        gridCount: Int = 2,
        spacing: CGFloat = 12,
        cardHeight: CGFloat = 120,
        cardAspectRatio: CGFloat = 160 / 120,
        cardShape: NACardShape = .roundedRectangle(cornerRadius: 24),
        backgroundColor: Color? = nil,
        onItemTap: ((NAGridViewV7Model) -> Void)? = nil
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
            NAGridViewV7CardView(
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
public struct NAGridViewV7CardView: View {
    public let category: NAGridViewV7Model
    public var cardShape: NACardShape
    public var overrideBackgroundColor: Color?
    
    public init(
        category: NAGridViewV7Model,
        cardShape: NACardShape = .roundedRectangle(cornerRadius: 24),
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
            RoundedRectangle(cornerRadius: cardShape.cornerRadius, style: .continuous)
                .fill(effectiveBackgroundColor)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: cardShape.cornerRadius, style: .continuous)
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

// MARK: - Usage Example
struct NAGridViewV7DemoScreen: View {
    var body: some View {
        NAGridViewV7(
            items: NAGridViewV7.defaultCategories,
            orientation: .vertical,
            gridCount: 2,
            spacing: 10,
            cardShape: .capsule,
            backgroundColor: Color(red: 232/255, green: 245/255, blue: 233/255)
        ) { selectedCategory in
            print("Selected: \(selectedCategory.title)")
        }
    }
}

#Preview {
    NAGridViewV7DemoScreen()
}
