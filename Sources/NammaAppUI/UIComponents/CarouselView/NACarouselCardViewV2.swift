//
//  NAProductCarouselCard.swift
//  NammaAppUI
//
//  Created by apple on 19/07/26.
//

import SwiftUI

// MARK: - Individual Card Component
struct NACarouselCardViewV2: View {
    let item: NACarouselV2Model
    var onTap: (() -> Void)? = nil
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(item.backgroundColor)
            
            HStack(spacing: 8) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(item.title)
                        .font(.system(size: 20, weight: .black, design: .rounded))
                        .foregroundColor(item.textColor)
                        .lineLimit(2)
                        .minimumScaleFactor(0.85)
                    
                    Text(item.subtitle)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(item.textColor.opacity(0.85))
                        .lineLimit(2)
                        .minimumScaleFactor(0.85)
                    
                    Spacer(minLength: 4)
                    
                    Button(action: { onTap?() }) {
                        Text(item.buttonText)
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(item.buttonTextColor)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(item.buttonBgColor)
                            .clipShape(Capsule())
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                }
                .padding(.leading, 18)
                .padding(.vertical, 16)
                
                Spacer(minLength: 0)

                Image(item.bannerImageName, bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.trailing, 10)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .contentShape(Rectangle())
        .onTapGesture {
            onTap?()
        }
    }
}

// MARK: - Preview Setup Engine
#Preview {
    let item = NACarouselV2Model(
        title: "Care You Can\nCount On",
        subtitle: "Feminine hygiene picks designed for ease & comfort",
        backgroundColor: Color(red: 236/255, green: 225/255, blue: 220/255),
        textColor: Color(red: 60/255, green: 20/255, blue: 20/255),
        buttonBgColor: .white,
        buttonTextColor: .black,
        bannerImageName: "chicken_product"
    )
    
    return NACarouselCardViewV2(item: item) {
        print("Card Tapped!")
    }
    .frame(height: 200)
    .padding(12)
}
