//
//  NAHorizontalGrid_NxN_V2.swift
//  NammaAppUI
//
//  Created by apple on 22/07/26.
//

import SwiftUI

// MARK: - Product Model
struct NAHorizontalGrid_NxN_V2Model: Identifiable {
    let id = UUID()
    let imageName: String
    let currentPrice: Int
    let originalPrice: Int
    let discountText: String
    let title: String
    let weightInfo: String
    var quantity: Int = 0
    var isFavorite: Bool = false
    var isAd: Bool = false
}

// MARK: - Custom Dotted Line Separator
struct DottedLineShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.width, y: rect.midY))
        return path
    }
}

struct NAHorizontalGrid_NxN_V2: View {
    @State private var products = [
        NAHorizontalGrid_NxN_V2Model(
            imageName: "ginger",
            currentPrice: 35,
            originalPrice: 63,
            discountText: "₹28 OFF",
            title: "Organically Grown Ginger",
            weightInfo: "100 g"
        ),
        NAHorizontalGrid_NxN_V2Model(
            imageName: "chilli",
            currentPrice: 8,
            originalPrice: 26,
            discountText: "₹18 OFF",
            title: "Chilli Green (Pachchai Mi...",
            weightInfo: "100 g"
        ),
        NAHorizontalGrid_NxN_V2Model(
            imageName: "coriander",
            currentPrice: 13,
            originalPrice: 40,
            discountText: "₹27 OFF",
            title: "Coriander Leaves (Koth...",
            weightInfo: "80 - 100 g"
        ),
        NAHorizontalGrid_NxN_V2Model(
            imageName: "ginger",
            currentPrice: 35,
            originalPrice: 63,
            discountText: "₹28 OFF",
            title: "Organically Grown Ginger",
            weightInfo: "100 g"
        ),
        NAHorizontalGrid_NxN_V2Model(
            imageName: "chilli",
            currentPrice: 8,
            originalPrice: 26,
            discountText: "₹18 OFF",
            title: "Chilli Green (Pachchai Mi...",
            weightInfo: "100 g"
        ),
        NAHorizontalGrid_NxN_V2Model(
            imageName: "coriander",
            currentPrice: 13,
            originalPrice: 40,
            discountText: "₹27 OFF",
            title: "Coriander Leaves (Koth...",
            weightInfo: "80 - 100 g"
        ),
        NAHorizontalGrid_NxN_V2Model(
            imageName: "ginger",
            currentPrice: 35,
            originalPrice: 63,
            discountText: "₹28 OFF",
            title: "Organically Grown Ginger",
            weightInfo: "100 g"
        ),
        NAHorizontalGrid_NxN_V2Model(
            imageName: "chilli",
            currentPrice: 8,
            originalPrice: 26,
            discountText: "₹18 OFF",
            title: "Chilli Green (Pachchai Mi...",
            weightInfo: "100 g"
        ),
        NAHorizontalGrid_NxN_V2Model(
            imageName: "coriander",
            currentPrice: 13,
            originalPrice: 40,
            discountText: "₹27 OFF",
            title: "Coriander Leaves (Koth...",
            weightInfo: "80 - 100 g"
        ),
        NAHorizontalGrid_NxN_V2Model(
            imageName: "ginger",
            currentPrice: 35,
            originalPrice: 63,
            discountText: "₹28 OFF",
            title: "Organically Grown Ginger",
            weightInfo: "100 g"
        ),
        NAHorizontalGrid_NxN_V2Model(
            imageName: "chilli",
            currentPrice: 8,
            originalPrice: 26,
            discountText: "₹18 OFF",
            title: "Chilli Green (Pachchai Mi...",
            weightInfo: "100 g"
        ),
        NAHorizontalGrid_NxN_V2Model(
            imageName: "coriander",
            currentPrice: 13,
            originalPrice: 40,
            discountText: "₹27 OFF",
            title: "Coriander Leaves (Koth...",
            weightInfo: "80 - 100 g"
        )
    ]
    
    private let gridRows: [GridItem] = [
        GridItem(.fixed(210), spacing: 24),
        GridItem(.fixed(210), spacing: 24)
    ]
        
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: gridRows, alignment: .top, spacing: 14) {
                ForEach($products) { $product in
                    NAHorizontalGrid_NxN_V2_CardView(product: $product)
                }
            }
        }
    }
}

struct NAHorizontalGrid_NxN_V2_CardView: View {
    @Binding var product: NAHorizontalGrid_NxN_V2Model
    
    private let primaryPink = Color(
        red: 236/255,
        green: 18/255,
        blue: 90/255
    )
    private let darkGreenBadge = Color(
        red: 16/255,
        green: 110/255,
        blue: 43/255
    )
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack(alignment: .bottomTrailing) {
            
                ZStack(alignment: .topLeading) {
                    Image(product.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 110, height: 110)
                        .background(Color(.systemGray6))
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 16,
                                style: .continuous
                            )
                        )

                    if product.isAd {
                        Text("Ad")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(.gray.opacity(0.8))
                            .padding(.leading, 6)
                            .padding(.top, 6)
                    }
                }

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
                .frame(width: 110, height: 110)
                
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
                    .padding(.horizontal, 10)
                    .frame(height: 36)
                    .background(primaryPink)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                    )
                    .padding(4)
                } else {
                    Button(action: { product.quantity = 1 }) {
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(primaryPink)
                            .frame(width: 36, height: 36)
                            .background(Color.white)
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 10,
                                    style: .continuous
                                )
                            )
                            .overlay(
                                RoundedRectangle(
                                    cornerRadius: 10,
                                    style: .continuous
                                )
                                .strokeBorder(primaryPink, lineWidth: 1.5)
                            )
                            .shadow(
                                color: Color.black.opacity(0.08),
                                radius: 3,
                                x: 0,
                                y: 2
                            )
                    }
                    .buttonStyle(.plain)
                    .padding(4)
                }
            }
            .frame(width: 110, height: 110)

            HStack(alignment: .center, spacing: 6) {
                Text("₹\(product.currentPrice)")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 3)
                    .background(darkGreenBadge)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                    )

                Text("₹\(product.originalPrice)")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.gray)
                    .strikethrough()
            }
            .padding(.top, 2)
            
            VStack(alignment: .leading, spacing: 4) {
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
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(
                        Color(red: 20/255, green: 20/255, blue: 20/255)
                    )
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(height: 34, alignment: .topLeading)
                
                Text(product.weightInfo)
                    .font(.system(size: 11, weight: .regular))
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 110)
    }
}

// MARK: - Preview Setup Engine
#Preview {
    NAHorizontalGrid_NxN_V2()
}
