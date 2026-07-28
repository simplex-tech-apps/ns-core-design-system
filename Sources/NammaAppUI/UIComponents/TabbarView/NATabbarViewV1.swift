//
//  NATabbarViewV1.swift
//  NammaAppUI
//
//  Created by apple on 20/07/26.
//

import SwiftUI

// MARK: - Models
public struct TabbarCategoryV1Model: Identifiable, Hashable {
    public init(title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
    }
    
    public let id = UUID()
    let title: String
    let imageName: String
}

public enum NammaShopCategoryTabRoute: String, CaseIterable, Identifiable {
    case all
    case grocery
    case fresh
    case meat
    case fish
    
    public var id: String { self.rawValue }
    
    public var title: String {
        switch self {
        case .all: return "All"
        case .grocery: return "Grocery"
        case .fresh: return "Fresh"
        case .meat: return "Meat"
        case .fish: return "Fish"
        }
    }
    
    public var iconName: String {
        switch self {
        case .all: return "square.grid.2x2.fill"
        case .grocery: return "basket.fill"
        case .fresh: return "leaf.fill"
        case .meat: return "fork.knife"
        case .fish: return "fish.fill"
        }
    }
}

public struct NATabbarViewV1: View {

    @Binding var selectedRoute: NammaShopCategoryTabRoute
    @Namespace private var categoryBarNamespace
    
    public init(selectedRoute: Binding<NammaShopCategoryTabRoute>) {
        self._selectedRoute = selectedRoute
    }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(NammaShopCategoryTabRoute.allCases) { route in
                            let isSelected = route == selectedRoute
                            
                            VStack(spacing: 6) {
                                Image(systemName: route.iconName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(isSelected ? .black : .black.opacity(0.6))
                                    .padding(.top, 6)
                                
                                Text(route.title)
                                    .font(
                                        .system(
                                            size: 11,
                                            weight: isSelected ? .bold : .medium
                                        )
                                    )
                                    .foregroundColor(
                                        isSelected ? .black : .black.opacity(0.6)
                                    )
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom, 4)
                                    .animation(.none, value: selectedRoute)
                                
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
                            .frame(width: 76)
                            .contentShape(Rectangle())
                            .id(route)
                            .onTapGesture {
                                withAnimation(
                                    .spring(response: 0.35, dampingFraction: 0.75)
                                ) {
                                    selectedRoute = route
                                    proxy.scrollTo(route, anchor: .center)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            
            Rectangle()
                .fill(Color.white.opacity(0.12))
                .frame(height: 1)
        }
    }
}

// MARK: - Preview Setup Engine
#Preview {
    struct PreviewWrapper: View {
        @State private var route: NammaShopCategoryTabRoute = .all
        
        var body: some View {
            VStack {
                NATabbarViewV1(selectedRoute: $route)
            }
        }
    }
    
    return PreviewWrapper()
}
