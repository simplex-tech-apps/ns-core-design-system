//
//  NAVerticalGrid_NxN_V2.swift
//  NammaAppUI
//
//  Created by apple on 22/07/26.
//

import SwiftUI

// MARK: - Ailment Category Model
struct NAVerticalGrid_NxN_V3Model: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let imageName: String
}

// MARK: - Main Grid View
public struct NAVerticalGrid_NxN_V3: View {
    let categories: [NAVerticalGrid_NxN_V3Model] = [
        NAVerticalGrid_NxN_V3Model(title: "All", imageName: "fish"),
        NAVerticalGrid_NxN_V3Model(title: "Premium Chicken", imageName: "fish"),
        NAVerticalGrid_NxN_V3Model(title: "Country Chicken",imageName: "fish"),
        NAVerticalGrid_NxN_V3Model(title: "Boneless", imageName: "fish"),
        NAVerticalGrid_NxN_V3Model(title: "Duck", imageName: "fish"),
        NAVerticalGrid_NxN_V3Model(title: "Quail",imageName: "fish"),
    ]
    
    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 12),
        count: 2
    )
    
    public var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(categories) { category in
                    NAVerticalGrid_NxN_V3CardView(category: category)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        .background(Color(.systemBackground))
    }
}

// MARK: - Individual Fresh Card View
struct NAVerticalGrid_NxN_V3CardView: View {
    let category: NAVerticalGrid_NxN_V3Model
    
    var body: some View {
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
                .frame(
                    maxHeight: 120
                )
        }
        .frame(maxWidth: .infinity)
        .frame(
            height: 120
        )
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(
                    Color(red: 219/255, green: 233/255, blue: 252/255)
                ) 
        )
    }
}

// MARK: - Preview Setup Engine
#Preview {
    NAVerticalGrid_NxN_V3()
}
