//
//  NATabbarViewV2.swift
//  NammaAppUI
//
//  Created by apple on 20/07/26.
//

import SwiftUI

// MARK: - Generic Dynamic Category Tab Model
public struct NATabCategoryItemModel: Identifiable, Hashable {
    public let id: String
    public let title: String
    public let iconName: String
    public let isSystemIcon: Bool
    
    public init(id: String, title: String, iconName: String, isSystemIcon: Bool = false) {
        self.id = id
        self.title = title
        self.iconName = iconName
        self.isSystemIcon = isSystemIcon
    }
}

// MARK: - Fully Configurable Dynamic Tabbar Component
public struct NATabbarViewV2: View {
    public var categories: [NATabCategoryItemModel]
    @Binding public var selectedCategoryId: String

    public var itemWidth: CGFloat
    public var iconBoxWidth: CGFloat
    public var iconBoxHeight: CGFloat
    public var iconWidth: CGFloat
    public var iconHeight: CGFloat
    public var cornerRadius: CGFloat
    public var fontSize: CGFloat
    public var indicatorHeight: CGFloat
    public var spacing: CGFloat

    public var activeIconBoxBackground: Color
    public var inactiveIconBoxBackground: Color
    public var activeTextColor: Color
    public var inactiveTextColor: Color
    public var indicatorColor: Color
    public var dividerColor: Color
    public var backgroundColor: Color
    public var horizontalPadding: CGFloat
    
    public var onCategorySelected: ((NATabCategoryItemModel) -> Void)?
    
    @Namespace private var categoryBarNamespace
    
    public init(
        categories: [NATabCategoryItemModel],
        selectedCategoryId: Binding<String>,
        itemWidth: CGFloat = 76,
        iconBoxWidth: CGFloat = 44,
        iconBoxHeight: CGFloat = 44,
        iconWidth: CGFloat = 30,
        iconHeight: CGFloat = 30,
        cornerRadius: CGFloat = 8,
        fontSize: CGFloat = 10,
        indicatorHeight: CGFloat = 2,
        activeIconBoxBackground: Color = Color(red: 218/255, green: 247/255, blue: 194/255).opacity(0.35),
        inactiveIconBoxBackground: Color = Color(.systemGray6),
        activeTextColor: Color = .black,
        inactiveTextColor: Color = .black.opacity(0.6),
        indicatorColor: Color = .green,
        dividerColor: Color = .black.opacity(0.05),
        backgroundColor: Color = .clear,
        horizontalPadding: CGFloat = 16,
        spacing: CGFloat = 0,
        onCategorySelected: ((NATabCategoryItemModel) -> Void)? = nil
    ) {
        self.categories = categories
        self._selectedCategoryId = selectedCategoryId
        self.itemWidth = itemWidth
        self.iconBoxWidth = iconBoxWidth
        self.iconBoxHeight = iconBoxHeight
        self.iconWidth = iconWidth
        self.iconHeight = iconHeight
        self.cornerRadius = cornerRadius
        self.fontSize = fontSize
        self.indicatorHeight = indicatorHeight
        self.activeIconBoxBackground = activeIconBoxBackground
        self.inactiveIconBoxBackground = inactiveIconBoxBackground
        self.activeTextColor = activeTextColor
        self.inactiveTextColor = inactiveTextColor
        self.indicatorColor = indicatorColor
        self.dividerColor = dividerColor
        self.backgroundColor = backgroundColor
        self.horizontalPadding = horizontalPadding
        self.onCategorySelected = onCategorySelected
        self.spacing = spacing
    }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: spacing) {
                        ForEach(categories) { category in
                            let isSelected = category.id == selectedCategoryId
                            
                            VStack(spacing: 6) {
                                ZStack {
                                    if category.isSystemIcon {
                                        Image(systemName: category.iconName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: iconWidth, height: iconHeight)
                                            .foregroundColor(isSelected ? activeTextColor : inactiveTextColor)
                                    } else {
                                        Image(category.iconName, bundle: .module)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: iconWidth, height: iconHeight)
                                    }
                                }
                                .frame(width: iconBoxWidth, height: iconBoxHeight)
                                .background(
                                    isSelected ? activeIconBoxBackground : inactiveIconBoxBackground
                                )
                                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                                .padding(.top, 6)

                                Text(category.title)
                                    .font(
                                        .system(
                                            size: fontSize,
                                            weight: isSelected ? .semibold : .regular
                                        )
                                    )
                                    .foregroundColor(isSelected ? activeTextColor : inactiveTextColor)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(height: 28, alignment: .top)
                                    .animation(.none, value: selectedCategoryId)

                                ZStack {
                                    if isSelected {
                                        Rectangle()
                                            .fill(indicatorColor)
                                            .frame(height: indicatorHeight)
                                            .matchedGeometryEffect(
                                                id: "activeTabLine",
                                                in: categoryBarNamespace
                                            )
                                    } else {
                                        Rectangle()
                                            .fill(Color.clear)
                                            .frame(height: indicatorHeight)
                                    }
                                }
                            }
                            .frame(width: itemWidth)
                            .contentShape(Rectangle())
                            .id(category.id)
                            .onTapGesture {
                                withAnimation(
                                    .spring(response: 0.35, dampingFraction: 0.75)
                                ) {
                                    selectedCategoryId = category.id
                                    proxy.scrollTo(category.id, anchor: .center)
                                }
                                onCategorySelected?(category)
                            }
                        }
                    }
                    .padding(.horizontal, horizontalPadding)
                }
            }
            .background(backgroundColor)

            Rectangle()
                .fill(dividerColor)
                .frame(height: 1)
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
    }
}

// MARK: - Preview Setup Engine
#Preview {
    struct PreviewWrapper: View {
        @State private var selectedId = "veggies"
        
        let tabItems = [
            NATabCategoryItemModel(id: "veggies", title: "Veggies", iconName: "leaf.fill", isSystemIcon: true),
            NATabCategoryItemModel(id: "fruits", title: "Fruits", iconName: "apple.logo", isSystemIcon: true),
            NATabCategoryItemModel(id: "dairy", title: "Dairy &\nMilk", iconName: "cup.and.saucer.fill", isSystemIcon: true),
            NATabCategoryItemModel(id: "bakery", title: "Breads &\nCakes", iconName: "birthday.cake.fill", isSystemIcon: true),
            NATabCategoryItemModel(id: "beverages", title: "Juices &\nDrinks", iconName: "wineglass.fill", isSystemIcon: true)
        ]
        
        var body: some View {
            NATabbarViewV2(
                categories: tabItems,
                selectedCategoryId: $selectedId,
                activeIconBoxBackground: Color.green.opacity(0.15),
                indicatorColor: .red
            ) { selectedCategory in
               
            }
        }
    }
    
    return PreviewWrapper()
}
