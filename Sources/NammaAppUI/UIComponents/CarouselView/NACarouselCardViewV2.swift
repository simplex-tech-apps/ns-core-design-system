//
//  NAProductCarouselCard.swift
//  NammaAppUI
//
//  Created by apple on 19/07/26.
//

import SwiftUI

// MARK: - Individual Fully Dynamic Carousel Card Component
public struct NACarouselCardViewV2: View {
    public var item: NACarouselV2Model

    public var cardCornerRadius: CGFloat
    public var imageWidth: CGFloat
    public var imageHeight: CGFloat
    public var titleFontSize: CGFloat
    public var subtitleFontSize: CGFloat
    public var buttonFontSize: CGFloat
    public var cardPadding: CGFloat

    public var onTap: (() -> Void)?
    public var onButtonTap: (() -> Void)?

    // MARK: - Primary Model Initializer
    public init(
        item: NACarouselV2Model,
        cardCornerRadius: CGFloat = 24,
        imageWidth: CGFloat = 140,
        imageHeight: CGFloat = 140,
        titleFontSize: CGFloat = 20,
        subtitleFontSize: CGFloat = 11,
        buttonFontSize: CGFloat = 10,
        cardPadding: CGFloat = 16,
        onButtonTap: (() -> Void)? = nil,
        onTap: (() -> Void)? = nil
    ) {
        self.item = item
        self.cardCornerRadius = cardCornerRadius
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        self.titleFontSize = titleFontSize
        self.subtitleFontSize = subtitleFontSize
        self.buttonFontSize = buttonFontSize
        self.cardPadding = cardPadding
        self.onButtonTap = onButtonTap
        self.onTap = onTap
    }

    // MARK: - Inline Convenience Initializer
    public init(
        title: String,
        subtitle: String? = nil,
        buttonText: String? = "SHOP NOW",
        backgroundColor: Color = Color(red: 236/255, green: 225/255, blue: 220/255),
        textColor: Color = Color(red: 60/255, green: 20/255, blue: 20/255),
        buttonBgColor: Color = .white,
        buttonTextColor: Color = .black,
        bannerImageName: String,
        isSystemImage: Bool = false,
        cardCornerRadius: CGFloat = 24,
        imageWidth: CGFloat = 140,
        imageHeight: CGFloat = 140,
        onButtonTap: (() -> Void)? = nil,
        onTap: (() -> Void)? = nil
    ) {
        self.item = NACarouselV2Model(
            title: title,
            subtitle: subtitle,
            buttonText: buttonText,
            backgroundColor: backgroundColor,
            textColor: textColor,
            buttonBgColor: buttonBgColor,
            buttonTextColor: buttonTextColor,
            bannerImageName: bannerImageName,
            isSystemImage: isSystemImage
        )
        self.cardCornerRadius = cardCornerRadius
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        self.titleFontSize = 20
        self.subtitleFontSize = 11
        self.buttonFontSize = 10
        self.cardPadding = 16
        self.onButtonTap = onButtonTap
        self.onTap = onTap
    }

    public var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: cardCornerRadius, style: .continuous)
                .fill(item.backgroundColor)

            HStack(spacing: 8) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(item.title)
                        .font(.system(size: titleFontSize, weight: .black, design: .rounded))
                        .foregroundColor(item.textColor)
                        .lineLimit(2)
                        .minimumScaleFactor(0.8)

                    if let subtitle = item.subtitle, !subtitle.isEmpty {
                        Text(subtitle)
                            .font(.system(size: subtitleFontSize, weight: .medium))
                            .foregroundColor(item.textColor.opacity(0.85))
                            .lineLimit(2)
                            .minimumScaleFactor(0.85)
                    }

                    Spacer(minLength: 4)

                    if let buttonText = item.buttonText, !buttonText.isEmpty {
                        Button(action: {
                            if let onButtonTap = onButtonTap {
                                onButtonTap()
                            } else {
                                onTap?()
                            }
                        }) {
                            Text(buttonText)
                                .font(.system(size: buttonFontSize, weight: .bold))
                                .foregroundColor(item.buttonTextColor)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(item.buttonBgColor)
                                .clipShape(Capsule())
                                .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
                        }
                        .buttonStyle(CarouselPressButtonStyle())
                    }
                }
                .padding(.leading, cardPadding)
                .padding(.vertical, cardPadding)

                Spacer(minLength: 0)

                Group {
                    if item.isSystemImage {
                        Image(systemName: item.bannerImageName)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(item.textColor)
                    } else {
                        Image(item.bannerImageName, bundle: .module)
                            .resizable()
                            .scaledToFit()
                    }
                }
                .frame(width: imageWidth, height: imageHeight)
                .padding(.trailing, 10)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: cardCornerRadius, style: .continuous))
        .contentShape(Rectangle())
        .onTapGesture {
            onTap?()
        }
    }
}

// MARK: - Press Feedback Button Style
struct CarouselPressButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}

// MARK: - Interactive Preview Showcase
#Preview {
    struct PreviewWrapper: View {
        let sampleItem1 = NACarouselV2Model(
            title: "Care You Can\nCount On",
            subtitle: "Feminine hygiene picks designed for ease & comfort",
            buttonText: "EXPLORE NOW",
            backgroundColor: Color(red: 236/255, green: 225/255, blue: 220/255),
            textColor: Color(red: 60/255, green: 20/255, blue: 20/255),
            buttonBgColor: .white,
            buttonTextColor: .black,
            bannerImageName: "chicken_product"
        )
        
        let sampleItem2 = NACarouselV2Model(
            title: "Fresh Farm\nMeat Combos",
            subtitle: "Up to 20% cashback on all orders today",
            buttonText: "CLAIM OFFER",
            backgroundColor: Color(red: 20/255, green: 80/255, blue: 50/255),
            textColor: .white,
            buttonBgColor: Color(red: 226/255, green: 18/255, blue: 73/255),
            buttonTextColor: .white,
            bannerImageName: "leaf.fill",
            isSystemImage: true
        )

        var body: some View {
            ScrollView {
                VStack(spacing: 20) {
                    NACarouselCardViewV2(
                        item: sampleItem1,
                        onButtonTap: { print("Button 1 Tapped!") },
                        onTap: { print("Card 1 Tapped!") }
                    )
                    .frame(height: 180)

                    NACarouselCardViewV2(
                        item: sampleItem2,
                        imageWidth: 100,
                        imageHeight: 100,
                        onButtonTap: { print("Button 2 Tapped!") },
                        onTap: { print("Card 2 Tapped!") }
                    )
                    .frame(height: 160)

                    NACarouselCardViewV2(
                        title: "Weekend Meat\nFiesta",
                        subtitle: "Fresh cuts delivered in 15 minutes",
                        buttonText: "ORDER NOW",
                        backgroundColor: Color(red: 254/255, green: 235/255, blue: 238/255),
                        textColor: Color(red: 180/255, green: 20/255, blue: 40/255),
                        buttonBgColor: Color(red: 180/255, green: 20/255, blue: 40/255),
                        buttonTextColor: .white,
                        bannerImageName: "flame.fill",
                        isSystemImage: true,
                        onTap: { print("Inline Card Tapped!") }
                    )
                    .frame(height: 170)
                }
                .padding(16)
            }
        }
    }

    return PreviewWrapper()
}
