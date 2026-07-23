//
//  NATabbarViewV1.swift
//  NammaAppUI
//
//  Created by apple on 20/07/26.
//

import SwiftUI

struct NATabbarViewV1: View {

    @State private var selectedCategory: String = "All"
    @Namespace private var categoryBarNamespace
    
    private let categories = [
        BeautyCategory(title: "All", imageName: "chicken_product"),
        BeautyCategory(title: "Curry Cuts", imageName: "chicken_product"),
        BeautyCategory(title: "Boneless &\nMince", imageName: "chicken_product"),
        BeautyCategory(title: "Speciality\nCuts", imageName: "chicken_product"),
        BeautyCategory(title: "Offals", imageName: "chicken_product"),
        BeautyCategory(title: "Combos", imageName: "chicken_product"),
        BeautyCategory(title: "Premium\nCuts", imageName: "chicken_product")
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(categories) { category in
                        VStack(spacing: 0) {
                            Image(category.imageName, bundle: .module)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 45, height: 45)
                            
                            Text(category.title)
                                .font(.system(size: 10, weight: category.title == selectedCategory ? .bold : .medium))
                                .foregroundColor(category.title == selectedCategory ? .black : .secondary)
                                .multilineTextAlignment(.center)
                                .frame(height: 32, alignment: .top)
                            
                            ZStack {
                                if category.title == selectedCategory {
                                    UnevenRoundedRectangle(topLeadingRadius: 32, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 32, style: .continuous)
                                        .fill(Color.black)
                                        .frame(height: 3)
                                        .matchedGeometryEffect(id: "activeTabLine", in: categoryBarNamespace)
                                } else {
                                    Rectangle()
                                        .fill(Color.clear)
                                        .frame(height: 2)
                                }
                            }
                        }
                        .frame(width: 80)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                                selectedCategory = category.title
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            Rectangle()
                .fill(Color.black.opacity(0.08))
                .frame(height: 1)
        }
    }
}

// MARK: - Preview Setup Engine
#Preview {
    NATabbarViewV1()
}
