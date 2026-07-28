//
//  NAHorizontalGrid_NxN_V3.swift
//  NammaAppUI
//
//  Created by apple on 22/07/26.
//

import SwiftUI

// MARK: - Product Model
public struct NAHorizontalGrid_NxN_V3Model: Identifiable {
    public let id = UUID()
    public let imageName: String
    public let currentPrice: Int
    public let originalPrice: Int
    public let discountText: String
    public let title: String
    public let weightInfo: String
    public var quantity: Int = 0
    public var isFavorite: Bool = false
    public var isAd: Bool = false

    public init(
        imageName: String,
        currentPrice: Int,
        originalPrice: Int,
        discountText: String,
        title: String,
        weightInfo: String,
        quantity: Int = 0,
        isFavorite: Bool = false,
        isAd: Bool = false
    ) {
        self.imageName = imageName
        self.currentPrice = currentPrice
        self.originalPrice = originalPrice
        self.discountText = discountText
        self.title = title
        self.weightInfo = weightInfo
        self.quantity = quantity
        self.isFavorite = isFavorite
        self.isAd = isAd
    }
}

struct DottedLineShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height / 2))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height / 2))
        return path
    }
}

// MARK: - Dynamic Grid Component
public struct NAHorizontalGrid_NxN_V3: View {
    @State private var products: [NAHorizontalGrid_NxN_V3Model]

    let rowCount: Int
    let columnCount: Int
    let scrollDirection: Axis.Set
    
    private var gridRows: [GridItem] {
        Array(repeating: GridItem(.fixed(210), spacing: 16), count: max(1, rowCount))
    }
    
    private var gridColumns: [GridItem] {
        let count = max(1, columnCount)
        return Array(repeating: GridItem(.flexible(), spacing: 12), count: count)
    }
    
    public init(
        rowCount: Int = 1,
        columnCount: Int = 2,
        scrollDirection: Axis.Set = .horizontal,
        products: [NAHorizontalGrid_NxN_V3Model] = NAHorizontalGrid_NxN_V3.defaultProducts
    ) {
        self.rowCount = rowCount
        self.columnCount = columnCount
        self.scrollDirection = scrollDirection
        self._products = State(initialValue: products)
    }
    
    public var body: some View {
        Group {
            if scrollDirection == .horizontal {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: gridRows, alignment: .top, spacing: 12) {
                        ForEach($products) { $product in
                            NAHorizontalGrid_NxN_V3_CardView(product: $product)
                                .frame(width: 110)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: gridColumns, spacing: 16) {
                        ForEach($products) { $product in
                            NAHorizontalGrid_NxN_V3_CardView(product: $product)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                }
            }
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
    }
}

// MARK: - Default Mock Data
extension NAHorizontalGrid_NxN_V3 {
    public static let defaultProducts: [NAHorizontalGrid_NxN_V3Model] = [
        NAHorizontalGrid_NxN_V3Model(imageName: "vegetables", currentPrice: 35, originalPrice: 63, discountText: "₹28 OFF", title: "Organically Grown Ginger", weightInfo: "100 g"),
        NAHorizontalGrid_NxN_V3Model(imageName: "vegetables", currentPrice: 8, originalPrice: 26, discountText: "₹18 OFF", title: "Chilli Green (Pachchai Mi...", weightInfo: "100 g"),
        NAHorizontalGrid_NxN_V3Model(imageName: "vegetables", currentPrice: 13, originalPrice: 40, discountText: "₹27 OFF", title: "Coriander Leaves (Koth...", weightInfo: "80 - 100 g"),
        NAHorizontalGrid_NxN_V3Model(imageName: "vegetables", currentPrice: 35, originalPrice: 63, discountText: "₹28 OFF", title: "Organically Grown Ginger", weightInfo: "100 g"),
        NAHorizontalGrid_NxN_V3Model(imageName: "vegetables", currentPrice: 8, originalPrice: 26, discountText: "₹18 OFF", title: "Chilli Green (Pachchai Mi...", weightInfo: "100 g"),
        NAHorizontalGrid_NxN_V3Model(imageName: "vegetables", currentPrice: 13, originalPrice: 40, discountText: "₹27 OFF", title: "Coriander Leaves (Koth...", weightInfo: "80 - 100 g"),
        NAHorizontalGrid_NxN_V3Model(imageName: "vegetables", currentPrice: 13, originalPrice: 40, discountText: "₹27 OFF", title: "Coriander Leaves (Koth...", weightInfo: "80 - 100 g"),
        NAHorizontalGrid_NxN_V3Model(imageName: "vegetables", currentPrice: 35, originalPrice: 63, discountText: "₹28 OFF", title: "Organically Grown Ginger", weightInfo: "100 g"),
    ]
}

// MARK: - Card Component
struct NAHorizontalGrid_NxN_V3_CardView: View {
    @Binding var product: NAHorizontalGrid_NxN_V3Model
    
    private let primaryPink = Color(red: 236/255, green: 18/255, blue: 90/255)
    private let darkGreenBadge = Color(red: 16/255, green: 110/255, blue: 43/255)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack(alignment: .bottomTrailing) {
                ZStack(alignment: .topLeading) {
                    Image(product.imageName, bundle: .module)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .aspectRatio(1.0, contentMode: .fill)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

                    if product.isAd {
                        Text("Ad")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(.gray.opacity(0.8))
                            .padding(.leading, 6)
                            .padding(.top, 6)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

                VStack {
                    HStack {
                        Spacer()
                        if product.isFavorite {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(primaryPink)
                                .padding(6)
                        }
                    }
                    Spacer()
                }
                
                if product.quantity > 0 {
                    HStack(spacing: 10) {
                        Button(action: { product.quantity -= 1 }) {
                            Image(systemName: "minus")
                                .font(.system(size: 12, weight: .bold))
                        }
                        
                        Text("\(product.quantity)")
                            .font(.system(size: 13, weight: .bold))
                        
                        Button(action: { product.quantity += 1 }) {
                            Image(systemName: "plus")
                                .font(.system(size: 12, weight: .bold))
                        }
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 6)
                    .frame(height: 30)
                    .background(primaryPink)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                } else {
                    Button(action: { product.quantity = 1 }) {
                        Image(systemName: "plus")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(primaryPink)
                            .frame(width: 30, height: 30)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .strokeBorder(primaryPink, lineWidth: 1.5)
                            )
                            .shadow(color: Color.black.opacity(0.08), radius: 3, x: 0, y: 2)
                    }
                    .buttonStyle(.plain)
                }
            }

            HStack(alignment: .center, spacing: 6) {
                Text("₹\(product.currentPrice)")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 3)
                    .background(darkGreenBadge)
                    .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))

                Text("₹\(product.originalPrice)")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.gray)
                    .strikethrough()
            }
            .padding(.top, 2)
            
            HStack(spacing: 6) {
                Text(product.discountText)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(darkGreenBadge)
                
                DottedLineShape()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [2, 3]))
                    .foregroundColor(Color.gray.opacity(0.3))
                    .frame(height: 1)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(product.title)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(Color(red: 20/255, green: 20/255, blue: 20/255))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(height: 34, alignment: .topLeading)
                
                Text(product.weightInfo)
                    .font(.system(size: 11, weight: .regular))
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Previews
#Preview("Horizontal (2 Rows Fixed Width)") {
    NAHorizontalGrid_NxN_V3(rowCount: 2, columnCount: 0, scrollDirection: .horizontal)
}

#Preview("Vertical (2 Columns Auto-Filled)") {
    NAHorizontalGrid_NxN_V3(rowCount: 0, columnCount: 2, scrollDirection: .vertical)
}

