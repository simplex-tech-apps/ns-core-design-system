//
//  NATabbarViewV1.swift
//  NammaAppUI
//
//  Created by apple on 20/07/26.
//

import SwiftUI

// MARK: - Models
public struct TabbarCategoryV2Model: Identifiable, Hashable {
    public init(title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
    }
    
    public let id = UUID()
    let title: String
    let imageName: String
}

public enum NammaShopFreshTabCategories: String, CaseIterable, Identifiable {
    case vegetable
    case fruit
    case seasonsBest
    case bread
    case dairy
    case milkshake
    case juice
    
    public var id: String { self.rawValue }
    
    public var title: String {
        switch self {
        case .vegetable: return "Veggies"
        case .fruit: return "Fruits"
        case .seasonsBest: return "Season's\nBest"
        case .bread: return "Breads & \nEgg"
        case .dairy: return "Dairy\nEssentials"
        case .milkshake: return "Milkshakes & \nYogurts"
        case .juice: return "Juices & \nSalads"
        }
    }
    
    public var iconName: String {
        switch self {
        case .vegetable: return "vegetables"
        case .fruit: return "vegetables"
        case .seasonsBest: return "vegetables"
        case .bread: return "vegetables"
        case .dairy: return "vegetables"
        case .milkshake: return "vegetables"
        case .juice: return "vegetables"
        }
    }
}

import SwiftUI

public struct NATabbarViewV2: View {

    @Binding var selectedCategory: NammaShopFreshTabCategories
    @Namespace private var categoryBarNamespace
    
    public init(selectedCategory: Binding<NammaShopFreshTabCategories>) {
        self._selectedCategory = selectedCategory
    }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 0) {
                        ForEach(NammaShopFreshTabCategories.allCases) { category in
                            let isSelected = category == selectedCategory
                            
                            VStack(spacing: 6) {
                                ZStack {
                                    Image(category.iconName, bundle: .module)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(isSelected ? .white : .black.opacity(0.7))
                                }
                                .frame(width: 44, height: 44)
                                .background(
                                    isSelected
                                    ? Color(red: 218/255, green: 247/255, blue: 194/255).opacity(0.25)
                                    : Color(.systemGray6)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .padding(.top, 6)
                                
                                Text(category.title)
                                    .font(
                                        .system(
                                            size: 10,
                                            weight: isSelected ? .semibold : .regular
                                        )
                                    )
                                    .foregroundColor(
                                        isSelected ? .black : .black.opacity(0.6)
                                    )
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(height: 28, alignment: .top)
                                    .animation(.none, value: selectedCategory)
                                
                                ZStack {
                                    if isSelected {
                                        Rectangle()
                                            .fill(Color.green)
                                            .frame(height: 2)
                                            .matchedGeometryEffect(
                                                id: "activeTabLine",
                                                in: categoryBarNamespace
                                            )
                                    } else {
                                        Rectangle()
                                            .fill(Color.clear)
                                            .frame(height: 2)
                                    }
                                }
                            }
                            .frame(width: 76)
                            .contentShape(Rectangle())
                            .id(category)
                            .onTapGesture {
                                withAnimation(
                                    .spring(response: 0.35, dampingFraction: 0.75)
                                ) {
                                    selectedCategory = category
                                    proxy.scrollTo(category, anchor: .center)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            
            Rectangle()
                .fill(Color.black.opacity(0.05))
                .frame(height: 1)
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
    }
}

// MARK: - Preview Setup Engine
#Preview {
    struct PreviewWrapper: View {
        @State private var category: NammaShopFreshTabCategories = .vegetable
        
        var body: some View {
            VStack {
                NATabbarViewV2(selectedCategory: $category)
            }
        }
    }
    
    return PreviewWrapper()
}
