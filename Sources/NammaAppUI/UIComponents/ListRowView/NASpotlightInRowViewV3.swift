//
//  NASpotlightInRowViewV1.swift
//  NammaAppUI
//
//  Created by apple on 20/07/26.
//

import SwiftUI

// MARK: - Main Master View
public struct NASpotlightInRowViewV3: View {
    
    private var topBannerGradient: LinearGradient {
        LinearGradient(
            colors: [Color(red: 255/255, green: 242/255, blue: 236/255), Color(red: 254/255, green: 245/255, blue: 242/255)],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    private let mockData = [
        NAGridViewV3Model(name: "Premium Goat + Chicken Combo", images: ["img1", "img2"]),
        NAGridViewV3Model(name: "Fresh Seafood Special Platter", images: ["img1", "img2"]),
        NAGridViewV3Model(name: "Curry Cut Mutton Family Pack", images: ["img1", "img2"]),
        NAGridViewV3Model(name: "Boneless Breast + Wings", images: ["img1", "img2"])
    ]
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Best of combos")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 145/255, green: 25/255, blue: 32/255))
                    
                    Text("Up to 10% off")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(Color(red: 198/255, green: 92/255, blue: 82/255))
                }
                Spacer()
                
                Image("chicken_product", bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 95)
            }
            .padding(.horizontal, 16)
            
            NAGridViewV3(
                items: mockData,
                orientation: .horizontal,
                gridCount: 1,
                baseCardHeight: 135
            )
            
            SeeAllButtonViewV1 {
                print("See All tapped!")
            }
            .padding(16)
        }
        .fixedSize(horizontal: false, vertical: true)
        .background(Color(red: 253/255, green: 246/255, blue: 243/255))
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
    }
}

// MARK: - Preview Setup Engine
#Preview {
    NASpotlightInRowViewV3()
}
