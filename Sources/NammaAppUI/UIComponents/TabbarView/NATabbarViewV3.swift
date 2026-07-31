//
//  NATabbarViewV3.swift
//  NammaAppUI
//
//  Created by apple on 01/08/26.
//

import SwiftUI

public protocol NATabbarRoute: Identifiable, Hashable {
    var title: String { get }
    var imageName: String { get }
}

// MARK: - Tab Model
public struct NATabbarViewV3Model: NATabbarRoute {
    public let id: String
    public let title: String
    public let imageName: String
    
    public init(id: String, title: String, imageName: String) {
        self.id = id
        self.title = title
        self.imageName = imageName
    }
}

public struct NATabbarViewV3: View {

    @Binding var selectedCategory: NATabbarViewV3Model
    @Namespace private var categoryBarNamespace
    var categories: [NATabbarViewV3Model]
    
    public init(
        categories: [NATabbarViewV3Model],
        selectedCategory: Binding<NATabbarViewV3Model>
    ) {
        self.categories = categories
        self._selectedCategory = selectedCategory
    }
    
    public var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 12) {
                    ForEach(categories) { category in
                        let isSelected = category.id == selectedCategory.id
                        
                        ZStack(alignment: .trailing) {
                            VStack(spacing: 4) {
                                // Image container with fixed background circle & scaled image
                                ZStack {
                                    // 1. Static Size Background Circle
                                    Circle()
                                        .fill(
                                            isSelected
                                            ? Color.green.opacity(0.15) // Selected light accent circle
                                            : Color.gray.opacity(0.08)  // Unselected light subtle circle
                                        )
                                        .frame(width: 48, height: 48)
                                    
                                    // 2. Scaled Image Only
                                    Image(category.imageName, bundle: .module)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 32, height: 32)
                                        // 🎯 Scale effect applies strictly to the Image
                                        .scaleEffect(isSelected ? 1.15 : 1.0)
                                        .animation(
                                            .spring(response: 0.3, dampingFraction: 0.7),
                                            value: isSelected
                                        )
                                }
                                .padding(.top, 4)
                                
                                Text(category.title)
                                    .font(
                                        .system(
                                            size: 11,
                                            weight: isSelected ? .semibold : .regular
                                        )
                                    )
                                    .foregroundColor(
                                        isSelected ? .black : .black.opacity(0.6)
                                    )
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom, 6)
                                    .padding(.horizontal, 2)
                                    .transaction { transaction in
                                        transaction.animation = nil
                                    }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.trailing, 6)
                        
                            // Right Side Indicator Line
                            ZStack {
                                if isSelected {
                                    UnevenRoundedRectangle(
                                        topLeadingRadius: 32,
                                        bottomLeadingRadius: 32,
                                        bottomTrailingRadius: 0,
                                        topTrailingRadius: 0,
                                        style: .continuous
                                    )
                                    .fill(Color.black)
                                    .frame(width: 4)
                                    .matchedGeometryEffect(
                                        id: "activeTabLine",
                                        in: categoryBarNamespace
                                    )
                                } else {
                                    Rectangle()
                                        .fill(Color.clear)
                                        .frame(width: 4)
                                }
                            }
                        }
                        .frame(width: 76)
                        .contentShape(Rectangle())
                        .id(category.id)
                        .onTapGesture {
                            withAnimation(
                                .spring(response: 0.35, dampingFraction: 0.75)
                            ) {
                                selectedCategory = category
                                proxy.scrollTo(category.id, anchor: .center)
                            }
                        }
                    }
                }
                .padding(.vertical, 16)
            }
        }
        .frame(width: 75)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.04), radius: 4, x: 4, y: 0)
    }
}

// MARK: - Preview Setup
#Preview {
    struct PreviewWrapper: View {
        let categories = [
            NATabbarViewV3Model(
                id: "1",
                title: "All",
                imageName: "chicken_product"
            ),
            NATabbarViewV3Model(
                id: "2",
                title: "Greeting Cards",
                imageName: "chicken_product"
            ),
            NATabbarViewV3Model(
                id: "3",
                title: "Bracelets",
                imageName: "chicken_product"
            ),
            NATabbarViewV3Model(
                id: "4",
                title: "Coffee Mugs",
                imageName: "chicken_product"
            ),
            NATabbarViewV3Model(
                id: "5",
                title: "Bouquets",
                imageName: "chicken_product"
            ),
            NATabbarViewV3Model(
                id: "6",
                title: "Plants",
                imageName: "chicken_product"
            )
        ]
        
        @State private var selectedCategory: NATabbarViewV3Model
        
        init() {
            _selectedCategory = State(initialValue: categories[0])
        }
        
        var body: some View {
            HStack(spacing: 0) {
                NATabbarViewV3(
                    categories: categories,
                    selectedCategory: $selectedCategory
                )
                Spacer()
            }
        }
    }
    
    return PreviewWrapper()
}
