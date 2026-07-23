//
//  NAVerticalGrid_Nx4.swift
//  NammaAppUI
//
//  Created by apple on 21/07/26.
//

import SwiftUI

// MARK: - Vertical Grid Model
struct NAVerticalGrid_NxN_V1Model: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let imageAsset: String
    let backgroundColor: Color
}

// MARK: - Main Grid View
struct NAVerticalGrid_NxN_V1: View {
    static let mintGreen = Color(red: 218/255, green: 247/255, blue: 194/255)
    
    let categories: [NAVerticalGrid_NxN_V1Model] = [
        NAVerticalGrid_NxN_V1Model(title: "Fresh\nFruits", imageAsset: "chicken_product", backgroundColor: mintGreen),
        NAVerticalGrid_NxN_V1Model(title: "Fresh\nVegetables", imageAsset: "chicken_product", backgroundColor: mintGreen),
        NAVerticalGrid_NxN_V1Model(title: "Dairy\nEssentials", imageAsset: "chicken_product", backgroundColor: mintGreen),
        NAVerticalGrid_NxN_V1Model(title: "Breads\n& Egg", imageAsset: "chicken_product", backgroundColor: mintGreen),
        
        NAVerticalGrid_NxN_V1Model(title: "Chicken &\nMutton", imageAsset: "chicken_product", backgroundColor: mintGreen),
        NAVerticalGrid_NxN_V1Model(title: "Milkshakes &\nYogurts", imageAsset: "chicken_product", backgroundColor: mintGreen),
        NAVerticalGrid_NxN_V1Model(title: "Breakfast\nNeeds", imageAsset: "chicken_product", backgroundColor: mintGreen),
        NAVerticalGrid_NxN_V1Model(title: "Fish &\nSeafood", imageAsset: "chicken_product", backgroundColor: mintGreen)
    ]

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 4)
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(categories) { category in
                    NAVerticalGrid_NxN_V1CardView(category: category)
                }
            }
        }
        .background(Color.white)
    }
}

// MARK: - Individual Category Card Component View
struct NAVerticalGrid_NxN_V1CardView: View {
    let category: NAVerticalGrid_NxN_V1Model
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(category.backgroundColor.opacity(0.25))
                Image(category.imageAsset, bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .padding(8)
            }
            .aspectRatio(1.0, contentMode: .fit)
            
            Text(category.title)
                .font(.system(size: 11, weight: .medium, design: .rounded))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(height: 34, alignment: .top)
                .padding(.horizontal, 2)
        }
    }
}

// MARK: - Preview Setup Engine
#Preview {
    NAVerticalGrid_NxN_V1()
}
