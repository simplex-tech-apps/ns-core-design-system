//
//  NACategoryOfProductsCarouselView.swift
//  NammaAppUI
//
//  Created by apple on 19/07/26.
//

import SwiftUI

// MARK: - Banner Item Model
public struct NACarouselV2Model: Identifiable, Hashable {
    public let id = UUID()
    public let title: String
    public let subtitle: String
    public let buttonText: String
    public let backgroundColor: Color
    public let textColor: Color
    public let buttonBgColor: Color
    public let buttonTextColor: Color
    public let bannerImageName: String
    
    public init(
        title: String,
        subtitle: String,
        buttonText: String = "SHOP NOW",
        backgroundColor: Color,
        textColor: Color = .white,
        buttonBgColor: Color = .white,
        buttonTextColor: Color = .black,
        bannerImageName: String
    ) {
        self.title = title
        self.subtitle = subtitle
        self.buttonText = buttonText
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.buttonBgColor = buttonBgColor
        self.buttonTextColor = buttonTextColor
        self.bannerImageName = bannerImageName
    }
}

public struct NACarouselViewV2: View {
    let products = [
        NACarouselV2Model(
            title: "Care You Can\nCount On",
            subtitle: "Feminine hygiene picks designed for ease & comfort",
            backgroundColor: Color(red: 236/255, green: 225/255, blue: 220/255),
            textColor: Color(red: 60/255, green: 20/255, blue: 20/255),
            buttonBgColor: .white,
            buttonTextColor: .black,
            bannerImageName: "chicken_product"
        ),
        NACarouselV2Model(
            title: "Sip, Chill &\nRepeat",
            subtitle: "Beat the heat with refreshing cold drinks",
            backgroundColor: Color(red: 70/255, green: 130/255, blue: 160/255),
            textColor: .white,
            buttonBgColor: .white,
            buttonTextColor: .black,
            bannerImageName: "chicken_product"
        ),
        NACarouselV2Model(
            title: "Ice Cream\nStore",
            subtitle: "From classics to gourmet, pick your favourite delight",
            backgroundColor: Color(red: 10/255, green: 90/255, blue: 210/255),
            textColor: .white,
            buttonBgColor: Color(red: 235/255, green: 30/255, blue: 85/255),
            buttonTextColor: .white,
            bannerImageName: "chicken_product"
        )
    ]
    
    private let gridRows: [GridItem] = [
        GridItem(.fixed(180), spacing: 24)
    ]
    
    public var body: some View {
        GeometryReader { outerGeometry in
            let screenWidth = outerGeometry.size.width
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: gridRows, alignment: .top, spacing: 12) {
                    ForEach(products) { item in
                        NACarouselCardViewV2(item: item) {
                            
                        }
                        .frame(width: screenWidth/1.25)
                    }
                }
                .padding(.horizontal, 12)
            }
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        .frame(height: 180)
    }
}

// MARK: - Preview Setup Engine
#Preview {
    NACarouselViewV2()
}
