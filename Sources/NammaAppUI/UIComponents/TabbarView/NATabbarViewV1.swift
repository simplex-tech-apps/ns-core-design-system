//
//  NATabbarViewV1.swift
//  NammaAppUI
//
//  Created by apple on 20/07/26.
//

import SwiftUI

// MARK: - Models
public struct TabbarCategoryModel: Identifiable, Hashable {
    public let id = UUID()
    let title: String
    let imageName: String
}

public struct NATabbarViewV1: View {

    @State private var selectedCategory: String = "All"
    @Namespace private var categoryBarNamespace
    
    var categories: [TabbarCategoryModel] = []
    
   public init(categories: [TabbarCategoryModel]) {
        self.categories = categories
        let defaultCategory = categories.first?.title ?? "All"
        self._selectedCategory = State(initialValue: defaultCategory)
    }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(categories) { category in
                            let isSelected = category.title == selectedCategory
                            
                            VStack(spacing: 0) {
                                Image(category.imageName, bundle: .module)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 36, height: 36)
                                
                                Text(category.title)
                                    .font(
                                        .system(
                                            size: 10,
                                            weight: isSelected ? .bold : .medium
                                        )
                                    )
                                    .foregroundColor(
                                        isSelected ? .black : .secondary
                                    )
                                    .multilineTextAlignment(.center)
                                    .frame(height: 32, alignment: .top)
                                    .animation(nil, value: selectedCategory)
                                
                                ZStack {
                                    if isSelected {
                                        UnevenRoundedRectangle(
                                            topLeadingRadius: 32,
                                            bottomLeadingRadius: 0,
                                            bottomTrailingRadius: 0,
                                            topTrailingRadius: 32,
                                            style: .continuous
                                        )
                                        .fill(Color.black)
                                        .frame(height: 4)
                                        .matchedGeometryEffect(
                                            id: "activeTabLine",
                                            in: categoryBarNamespace
                                        )
                                    } else {
                                        Rectangle()
                                            .fill(Color.clear)
                                            .frame(height: 4)
                                    }
                                }
                            }
                            .frame(width: 80)
                            .contentShape(Rectangle())
                            .id(category.title)
                            .onTapGesture {
                                withAnimation(
                                    .spring(response: 0.35, dampingFraction: 0.75)
                                ) {
                                    selectedCategory = category.title
                                    proxy.scrollTo(category.title, anchor: .center)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            
            Rectangle()
                .fill(Color.black.opacity(0.08))
                .frame(height: 1)
        }
    }
}

// MARK: - Preview Setup Engine
#Preview {
    var categories = [
        TabbarCategoryModel(title: "All", imageName: "chicken_product"),
        TabbarCategoryModel(title: "Curry Cuts", imageName: "chicken_product"),
        TabbarCategoryModel(title: "Boneless &\nMince", imageName: "chicken_product"),
        TabbarCategoryModel(title: "Speciality\nCuts", imageName: "chicken_product"),
        TabbarCategoryModel(title: "Offals", imageName: "chicken_product"),
        TabbarCategoryModel(title: "Combos", imageName: "chicken_product"),
        TabbarCategoryModel(title: "Premium\nCuts", imageName: "chicken_product")
    ]
    NATabbarViewV1(categories: categories)
}
