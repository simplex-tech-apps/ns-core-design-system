//
//  NAHorizontalGrid_NxN_V3.swift
//  NammaAppUI
//
//  Created by apple on 22/07/26.
//

import SwiftUI

// MARK: - Product Model
public struct NAHorizontalGrid_NxN_V2Model: Identifiable {
    public let id = UUID()
    let name: String
    let images: [String]
}

// MARK: - Dynamic Grid Component
public struct NAHorizontalGrid_NxN_V2: View {
    let items = [
        NAHorizontalGrid_NxN_V2Model(
            name: "Premium Goat CurryCut + Premium Chicken...",
            images: ["bio_p1", "bio_p2"]
        ),
        NAHorizontalGrid_NxN_V2Model(
            name: "Premium Goat CurryCut + Premium Chicken...",
            images: ["bio_p1", "bio_p2"]
        ),
        NAHorizontalGrid_NxN_V2Model(
            name: "Premium Goat CurryCut + Premium Chicken...",
            images: ["bio_p1", "bio_p2"]
        )
    ]
    
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 14) {
                ForEach(items) { item in
                    NAHorizontalGrid_NxN_V2_CardView(item: item)
                        .frame(width: 135)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
    }
}

// MARK: - Card Component
struct NAHorizontalGrid_NxN_V2_CardView: View {
    let item: NAHorizontalGrid_NxN_V2Model
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                Text(item.name)
                    .font(.system(size: 11, weight: .semibold, design: .rounded))
                    .foregroundColor(
                        Color(red: 50/255, green: 50/255, blue: 50/255)
                    )
                
                Spacer()
                
                Image(systemName: "arrow.right")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.black)
                    .frame(width: 26, height: 26)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(
                        color: Color.black.opacity(0.05),
                        radius: 2,
                        x: 0,
                        y: 1
                    )
            }
            .padding(.horizontal, 12)
            .padding(.top, 10)
            
            Spacer()
            
            HStack(spacing: 8) {
                ForEach(item.images, id: \.self) { imgStr in
                    ZStack {
                        Color.white
                        Image("chicken_product", bundle: .module)
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(width: 52, height: 52)
                    .cornerRadius(12)
                    .shadow(
                        color: Color.black.opacity(0.03),
                        radius: 2,
                        x: 0,
                        y: 1
                    )
                }
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 10)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 140)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous).fill(
                Color(red: 254/255, green: 224/255, blue: 195/255)
            )
        )
    }
}

// MARK: - Previews
#Preview() {
    NAHorizontalGrid_NxN_V2()
}

struct LineStylePattern: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        return path
    }
}

