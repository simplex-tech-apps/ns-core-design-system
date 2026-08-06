//
//  NACategoryOfProductsCarouselView.swift
//  NammaAppUI
//
//  Created by apple on 19/07/26.
//

import SwiftUI

// MARK: - Fully Dynamic Carousel Card Data Model
public struct NACarouselV2Model: Identifiable, Hashable {
    public let id: UUID
    public var title: String
    public var subtitle: String?
    public var buttonText: String?
    public var backgroundColor: Color
    public var textColor: Color
    public var buttonBgColor: Color
    public var buttonTextColor: Color
    public var bannerImageName: String
    public var isSystemImage: Bool
    
    public init(
        id: UUID = UUID(),
        title: String,
        subtitle: String? = nil,
        buttonText: String? = "SHOP NOW",
        backgroundColor: Color = Color(red: 236/255, green: 225/255, blue: 220/255),
        textColor: Color = Color(red: 60/255, green: 20/255, blue: 20/255),
        buttonBgColor: Color = .white,
        buttonTextColor: Color = .black,
        bannerImageName: String,
        isSystemImage: Bool = false
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.buttonText = buttonText
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.buttonBgColor = buttonBgColor
        self.buttonTextColor = buttonTextColor
        self.bannerImageName = bannerImageName
        self.isSystemImage = isSystemImage
    }
}

public struct NACarouselViewV2: View {
    let items = [
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
    
    public init() {}
    
    public var body: some View {
        GeometryReader { outerGeometry in
            let screenWidth = outerGeometry.size.width
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: gridRows, alignment: .top, spacing: 12) {
                    ForEach(items) { item in
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
