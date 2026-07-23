//
//  NAVerticalGrid_NxN_V2.swift
//  NammaAppUI
//
//  Created by apple on 22/07/26.
//

import SwiftUI

// MARK: - Fresh Category Model
struct NAVerticalGrid_NxN_V2Model: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let productImageName: String
}

// MARK: - Main Grid View
public struct NAVerticalGrid_NxN_V2: View {
    let categories: [NAVerticalGrid_NxN_V2Model] = [
        NAVerticalGrid_NxN_V2Model(
            title: "Marine/\nSea",
            productImageName: "fish"
        ),
        NAVerticalGrid_NxN_V2Model(
            title: "Freshwater\n/Lake",
            productImageName: "fish"
        ),
        NAVerticalGrid_NxN_V2Model(
            title: "Crab",
            productImageName: "fish"
        ),
        NAVerticalGrid_NxN_V2Model(
            title: "Prawns/\nShell Fish",
            productImageName: "fish"
        ),
        NAVerticalGrid_NxN_V2Model(
            title: "Exotic",
            productImageName: "fish"
        ),
        NAVerticalGrid_NxN_V2Model(
            title: "Boneless",
            productImageName: "fish"
        ),
        NAVerticalGrid_NxN_V2Model(
            title: "Steaks",
            productImageName: "fish"
        ),
        NAVerticalGrid_NxN_V2Model(
            title: "Dry Fish",
            productImageName: "fish"
        ),
        NAVerticalGrid_NxN_V2Model(
            title: "Freshly Frozen",
            productImageName: "fish"
        )
    ]
    
    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 8),
        count: 3
    )
    
    public init() {}
    
    public var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(categories) { category in
                    NAVerticalGrid_NxN_V2CardView(category: category)
                }
            }
            .padding(.horizontal, 12)
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        .background(Color(.systemBackground))
    }
}

// MARK: - Individual Fresh Card View
struct NAVerticalGrid_NxN_V2CardView: View {
    let category: NAVerticalGrid_NxN_V2Model
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
        
            VStack(alignment: .leading, spacing: 0) {
                Text(category.title)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(
                        Color(red: 44/255, green: 53/255, blue: 71/255)
                    )
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .padding(.top, 14)
            .padding(.horizontal, 12)
            
            Image(category.productImageName, bundle: .module)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 85)
                .padding(
                    .bottom,
                    0
                )
                .padding(.trailing, 0)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 140)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(
                    Color(red: 243/255, green: 245/255, blue: 248/255)
                )
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .strokeBorder(
                    Color.gray.opacity(0.2),
                    lineWidth: 1.5
                ) 
        )
    }
}

// MARK: - Preview Setup Engine
#Preview {
    NAVerticalGrid_NxN_V2()
}
