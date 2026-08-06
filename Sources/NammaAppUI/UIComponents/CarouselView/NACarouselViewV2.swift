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

// MARK: - Fully Dynamic Carousel Container View
public struct NACarouselViewV2: View {
    @Binding public var items: [NACarouselV2Model]
    
    public var cardHeight: CGFloat
    public var cardWidthRatio: CGFloat
    public var explicitCardWidth: CGFloat?
    public var gridSpacing: CGFloat
    public var horizontalPadding: CGFloat
    public var cardCornerRadius: CGFloat
    public var imageWidth: CGFloat
    public var imageHeight: CGFloat
    
    public var onItemTap: ((NACarouselV2Model) -> Void)?
    public var onButtonTap: ((NACarouselV2Model) -> Void)?
    
    private var gridRows: [GridItem] {
        [GridItem(.fixed(cardHeight), spacing: gridSpacing)]
    }

    public init(
        items: Binding<[NACarouselV2Model]>,
        cardHeight: CGFloat = 180,
        cardWidthRatio: CGFloat = 1.25,
        explicitCardWidth: CGFloat? = nil,
        gridSpacing: CGFloat = 12,
        horizontalPadding: CGFloat = 12,
        cardCornerRadius: CGFloat = 24,
        imageWidth: CGFloat = 140,
        imageHeight: CGFloat = 140,
        onButtonTap: ((NACarouselV2Model) -> Void)? = nil,
        onItemTap: ((NACarouselV2Model) -> Void)? = nil
    ) {
        self._items = items
        self.cardHeight = cardHeight
        self.cardWidthRatio = cardWidthRatio
        self.explicitCardWidth = explicitCardWidth
        self.gridSpacing = gridSpacing
        self.horizontalPadding = horizontalPadding
        self.cardCornerRadius = cardCornerRadius
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        self.onButtonTap = onButtonTap
        self.onItemTap = onItemTap
    }

    public var body: some View {
        GeometryReader { outerGeometry in
            let screenWidth = outerGeometry.size.width
            let calculatedWidth = explicitCardWidth ?? (screenWidth / cardWidthRatio)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: gridRows, alignment: .center, spacing: gridSpacing) {
                    ForEach(items) { item in
                        NACarouselCardViewV2(
                            item: item,
                            cardCornerRadius: cardCornerRadius,
                            imageWidth: imageWidth,
                            imageHeight: imageHeight,
                            onButtonTap: {
                                if let onButtonTap = onButtonTap {
                                    onButtonTap(item)
                                } else {
                                    onItemTap?(item)
                                }
                            },
                            onTap: {
                                onItemTap?(item)
                            }
                        )
                        .frame(width: calculatedWidth, height: cardHeight)
                    }
                }
                .padding(.horizontal, horizontalPadding)
            }
        }
        .frame(height: cardHeight)
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
    }
}

// MARK: - Default Input Parameters & Mock Extensions
extension NACarouselViewV2 {
    public static let defaultItems = [
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
}

// MARK: - Demo Usage Screen
struct NACarouselViewV2DemoScreen: View {
    @State private var carouselItems = NACarouselViewV2.defaultItems

    var body: some View {
        NACarouselViewV2(
            items: $carouselItems,
            cardHeight: 180,
            cardWidthRatio: 1.25,
            gridSpacing: 12,
            horizontalPadding: 16,
            onButtonTap: { selectedItem in
               
            },
            onItemTap: { selectedItem in
               
            }
        )
    }
}

// MARK: - Preview Setup Engine
#Preview {
    NACarouselViewV2DemoScreen()
}
