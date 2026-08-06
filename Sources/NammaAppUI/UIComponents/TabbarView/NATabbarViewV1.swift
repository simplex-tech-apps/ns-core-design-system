//
//  NATabbarViewV1.swift
//  NammaAppUI
//
//  Created by apple on 20/07/26.
//

import SwiftUI

// MARK: - Generic Dynamic Tab Model
public struct NATabItemModel: Identifiable, Hashable {
    public let id: String
    public let title: String
    public let iconName: String
    public let isSystemIcon: Bool
    
    public init(id: String, title: String, iconName: String, isSystemIcon: Bool = true) {
        self.id = id
        self.title = title
        self.iconName = iconName
        self.isSystemIcon = isSystemIcon
    }
}

// MARK: - Dynamic Tabbar Component
public struct NATabbarViewV1: View {
    public var items: [NATabItemModel]
    @Binding public var selectedTabId: String
    
    public var itemWidth: CGFloat
    public var itemSpacing: CGFloat
    public var iconSize: CGFloat
    public var fontSize: CGFloat
    public var indicatorHeight: CGFloat

    public var activeColor: Color
    public var inactiveColor: Color
    public var indicatorColor: Color
    public var dividerColor: Color
    public var backgroundColor: Color
    public var horizontalPadding: CGFloat
    
    public var onTabSelected: ((NATabItemModel) -> Void)?
    
    @Namespace private var categoryBarNamespace
    
    public init(
        items: [NATabItemModel] = NATabbarViewV1.defaultTabs,
        selectedTabId: Binding<String>,
        itemWidth: CGFloat = 76,
        itemSpacing: CGFloat = 8,
        iconSize: CGFloat = 16,
        fontSize: CGFloat = 11,
        indicatorHeight: CGFloat = 4,
        activeColor: Color = .black,
        inactiveColor: Color = .black.opacity(0.6),
        indicatorColor: Color = .black,
        dividerColor: Color = .white.opacity(0.12),
        backgroundColor: Color = .clear,
        horizontalPadding: CGFloat = 16,
        onTabSelected: ((NATabItemModel) -> Void)? = nil
    ) {
        self.items = items
        self._selectedTabId = selectedTabId
        self.itemWidth = itemWidth
        self.itemSpacing = itemSpacing
        self.iconSize = iconSize
        self.fontSize = fontSize
        self.indicatorHeight = indicatorHeight
        self.activeColor = activeColor
        self.inactiveColor = inactiveColor
        self.indicatorColor = indicatorColor
        self.dividerColor = dividerColor
        self.backgroundColor = backgroundColor
        self.horizontalPadding = horizontalPadding
        self.onTabSelected = onTabSelected
    }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: itemSpacing) {
                        ForEach(items) { item in
                            let isSelected = item.id == selectedTabId
                            
                            VStack(spacing: 6) {
                                Group {
                                    if item.isSystemIcon {
                                        Image(systemName: item.iconName)
                                            .resizable()
                                            .scaledToFit()
                                    } else {
                                        Image(item.iconName, bundle: .module)
                                            .resizable()
                                            .scaledToFit()
                                    }
                                }
                                .frame(width: iconSize, height: iconSize)
                                .foregroundColor(isSelected ? activeColor : inactiveColor)
                                .padding(.top, 6)
                                
                                Text(item.title)
                                    .font(
                                        .system(
                                            size: fontSize,
                                            weight: isSelected ? .bold : .medium
                                        )
                                    )
                                    .foregroundColor(isSelected ? activeColor : inactiveColor)
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom, 4)
                                    .animation(.none, value: selectedTabId)

                                ZStack {
                                    if isSelected {
                                        UnevenRoundedRectangle(
                                            topLeadingRadius: 32,
                                            bottomLeadingRadius: 0,
                                            bottomTrailingRadius: 0,
                                            topTrailingRadius: 32,
                                            style: .continuous
                                        )
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
                            .id(item.id)
                            .onTapGesture {
                                withAnimation(
                                    .spring(response: 0.35, dampingFraction: 0.75)
                                ) {
                                    selectedTabId = item.id
                                    proxy.scrollTo(item.id, anchor: .center)
                                }
                                onTabSelected?(item)
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
    }
}

// MARK: - Default Mock Data Extension
extension NATabbarViewV1 {
    public static let defaultTabs: [NATabItemModel] = [
        NATabItemModel(id: "all", title: "All", iconName: "square.grid.2x2.fill"),
        NATabItemModel(id: "grocery", title: "Grocery", iconName: "basket.fill"),
        NATabItemModel(id: "fresh", title: "Fresh", iconName: "leaf.fill"),
        NATabItemModel(id: "meat", title: "Meat", iconName: "fork.knife"),
        NATabItemModel(id: "fish", title: "Fish", iconName: "fish.fill")
    ]
}

// MARK: - Interactive Dynamic Preview
#Preview {
    struct PreviewWrapper: View {
        @State private var selectedTab = "meat"
        
        let tabOptions = [
            NATabItemModel(id: "meat", title: "Fresh Meat", iconName: "fork.knife"),
            NATabItemModel(id: "chicken", title: "Chicken", iconName: "bird.fill"),
            NATabItemModel(id: "seafood", title: "Seafood", iconName: "fish.fill"),
            NATabItemModel(id: "eggs", title: "Eggs", iconName: "oval.fill"),
            NATabItemModel(id: "combos", title: "Combos", iconName: "tag.fill"),
            NATabItemModel(id: "spices", title: "Spices", iconName: "flame.fill")
        ]
        
        var body: some View {
            NATabbarViewV1(
                items: tabOptions,
                selectedTabId: $selectedTab,
                itemWidth: 85,
                activeColor: .white,
                inactiveColor: .gray,
                indicatorColor: Color(red: 236/255, green: 18/255, blue: 90/255),
                backgroundColor: Color(red: 20/255, green: 20/255, blue: 20/255)
            ) { selected in
               
            }
        }
    }
    
    return PreviewWrapper()
}
