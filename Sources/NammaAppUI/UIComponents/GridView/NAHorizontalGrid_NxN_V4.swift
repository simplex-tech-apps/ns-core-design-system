//
//  NAHorizontalGrid_NxN_V2.swift
//  NammaAppUI
//
//  Created by apple on 22/07/26.
//

import SwiftUI

// MARK: - Product Model
public struct NAHorizontalGrid_NxN_V4Model: Identifiable {
    public let id = UUID()
    public let title: String
    public let productImage: String
    
    public init(title: String, productImage: String) {
        self.title = title
        self.productImage = productImage
    }
}

// MARK: - Dynamic Grid View (Dynamic Columns & Rows)
public struct NAHorizontalGrid_NxN_V4: View {
    
    let categories: [NAHorizontalGrid_NxN_V4Model]
    let columnCount: Int
    let rowCount: Int?
    
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 8), count: max(1, columnCount))
    }
    
    private var displayedCategories: [NAHorizontalGrid_NxN_V4Model] {
        if let rowCount = rowCount {
            let maxItems = max(1, columnCount * rowCount)
            return Array(categories.prefix(maxItems))
        }
        return categories
    }
    
    public init(
        columnCount: Int = 4,
        rowCount: Int? = nil,
        categories: [NAHorizontalGrid_NxN_V4Model] = NAHorizontalGrid_NxN_V4.defaultCategories
    ) {
        self.columnCount = columnCount
        self.rowCount = rowCount
        self.categories = categories
    }
    
    public var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(displayedCategories) { category in
                    NAHorizontalGrid_NxN_V4_CardView(category: category)
                }
            }
            .padding(.horizontal, 14)
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        .background(Color(.systemBackground))
    }
}

// MARK: - Default Mock Data
extension NAHorizontalGrid_NxN_V4 {
    public static let defaultCategories: [NAHorizontalGrid_NxN_V4Model] = [
        NAHorizontalGrid_NxN_V4Model(title: "Cough, Cold\n& Fever", productImage: "chicken_product"),
        NAHorizontalGrid_NxN_V4Model(title: "Vitamin &\nSupplements", productImage: "chicken_product"),
        NAHorizontalGrid_NxN_V4Model(title: "Pain\nRelief", productImage: "chicken_product"),
        NAHorizontalGrid_NxN_V4Model(title: "Elderly\nCare", productImage: "chicken_product"),
        NAHorizontalGrid_NxN_V4Model(title: "Ayurveda &\nImmnunity", productImage: "chicken_product"),
        NAHorizontalGrid_NxN_V4Model(title: "Stomach\nCare", productImage: "chicken_product"),
        NAHorizontalGrid_NxN_V4Model(title: "Derma\nCare", productImage: "chicken_product"),
        NAHorizontalGrid_NxN_V4Model(title: "Medical\nDevices", productImage: "chicken_product"),
        NAHorizontalGrid_NxN_V4Model(title: "First\nAid", productImage: "chicken_product"),
        NAHorizontalGrid_NxN_V4Model(title: "Protein &\nSupplemment", productImage: "chicken_product"),
        NAHorizontalGrid_NxN_V4Model(title: "Rehydration & ORS", productImage: "chicken_product"),
        NAHorizontalGrid_NxN_V4Model(title: "Sexual\nWellness", productImage: "chicken_product")
    ]
}

// MARK: - Card Component
struct NAHorizontalGrid_NxN_V4_CardView: View {
    let category: NAHorizontalGrid_NxN_V4Model
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color(red: 238/255, green: 244/255, blue: 252/255))
                
                Image(category.productImage, bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .padding(6)
            }
            .aspectRatio(0.80, contentMode: .fit)
            
            Text(category.title)
                .font(.system(size: 10, weight: .semibold, design: .default))
                .foregroundColor(Color(red: 44/255, green: 53/255, blue: 71/255))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(height: 32, alignment: .center)
                .padding(.horizontal, 2)
        }
    }
}

// MARK: - Preview Variations
#Preview("4 Columns x 2 Rows (8 items)") {
    NAHorizontalGrid_NxN_V4(columnCount: 4, rowCount: 2)
}

