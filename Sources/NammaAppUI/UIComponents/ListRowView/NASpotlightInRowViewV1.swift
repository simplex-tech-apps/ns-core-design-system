//
//  NASpotlightInRowViewV1.swift
//  NammaAppUI
//
//  Created by apple on 20/07/26.
//

import SwiftUI

// MARK: - Main Master Generic View
public struct NASpotlightInRowViewV1<Content: View>: View {

    public var title: String
    public var subtitle: String?
    public var heroImageName: String?
    public var titleColor: Color
    public var subtitleColor: Color
    public var backgroundColor: Color
    
    public var showTabbar: Bool
    public var categories: [NATabCategoryItemModel]
    @Binding public var selectedCategoryId: String
    public var activeIconBoxBackground: Color
    public var indicatorColor: Color
    
    public var onTabSelected: ((NATabCategoryItemModel) -> Void)?
    public var onClickSeeAll: (() -> Void)?
    
    @ViewBuilder public var content: () -> Content

    public init(
        title: String = "Best of chickens",
        subtitle: String? = "Up to 10% off",
        heroImageName: String? = "makeup_hero_group",
        titleColor: Color = Color(red: 145/255, green: 25/255, blue: 32/255),
        subtitleColor: Color = Color(red: 198/255, green: 92/255, blue: 82/255),
        backgroundColor: Color = Color(red: 253/255, green: 246/255, blue: 243/255),
        showTabbar: Bool = true,
        categories: [NATabCategoryItemModel] = [],
        selectedCategoryId: Binding<String> = .constant("veggies"),
        activeIconBoxBackground: Color = Color.green.opacity(0.15),
        indicatorColor: Color = .red,
        onTabSelected: ((NATabCategoryItemModel) -> Void)? = nil,
        onClickSeeAll: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.heroImageName = heroImageName
        self.titleColor = titleColor
        self.subtitleColor = subtitleColor
        self.backgroundColor = backgroundColor
        self.showTabbar = showTabbar
        self.categories = categories
        self._selectedCategoryId = selectedCategoryId
        self.activeIconBoxBackground = activeIconBoxBackground
        self.indicatorColor = indicatorColor
        self.onTabSelected = onTabSelected
        self.onClickSeeAll = onClickSeeAll
        self.content = content
    }

    public var body: some View {
        VStack(spacing: 12) {
            VStack(spacing: 0) {
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundColor(titleColor)
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                        
                        if let subtitle = subtitle {
                            Text(subtitle)
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .foregroundColor(subtitleColor)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    
                    Spacer()
                    
                    if let heroImageName = heroImageName {
                        Image(heroImageName, bundle: .module)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 130, height: 95)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)

                if showTabbar && !categories.isEmpty {
                    NATabbarViewV2(
                        categories: categories,
                        selectedCategoryId: $selectedCategoryId,
                        activeIconBoxBackground: activeIconBoxBackground,
                        indicatorColor: indicatorColor
                    ) { selectedCategory in
                        onTabSelected?(selectedCategory)
                    }
                }

                content().padding(.vertical, 16)

                SeeAllButtonViewV1 {
                    onClickSeeAll?()
                }
                .padding(.bottom, 16)
            }
            .background(backgroundColor)
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
    }
}

// MARK: - See All Button V1 Component
public struct SeeAllButtonViewV1: View {
    public var action: () -> Void = {}

    private let containerBackground = Color.white
    private let darkTextColor = Color(red: 30/255, green: 30/255, blue: 30/255)
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack {
                Text("See All")
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(darkTextColor)
                
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(Color.black)
                        .shadow(color: Color.black.opacity(0.04), radius: 3, x: 0, y: 1)
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color.white)
                }
                .frame(width: 38, height: 38)
            }
            .padding(.leading, 20)
            .padding(.trailing, 8)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .background(containerBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .buttonStyle(SeeAllPressButtonStyle())
    }
}

// MARK: - See All Button V2 Component
public struct SeeAllButtonViewV2: View {
    public var action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Text("See All")
                    .font(.system(size: 14, weight: .bold))
                
                Image(systemName: "chevron.right.2")
                    .font(.system(size: 12, weight: .bold))
            }
            .foregroundColor(Color(red: 10/255, green: 100/255, blue: 240/255))
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(Color(red: 240/255, green: 246/255, blue: 255/255))
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        .buttonStyle(SeeAllPressButtonStyle())
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

// MARK: - Press Feedback Style
struct SeeAllPressButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.99 : 1.0)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}

// MARK: - Interactive Preview Demo
#Preview {
    struct PreviewWrapper: View {
        @State private var selectedTab = "veggies"
        
        let tabbarItems = [
            NATabCategoryItemModel(id: "veggies", title: "Veggies", iconName: "leaf.fill", isSystemIcon: true),
            NATabCategoryItemModel(id: "fruits", title: "Fruits", iconName: "apple.logo", isSystemIcon: true),
            NATabCategoryItemModel(id: "dairy", title: "Dairy &\nMilk", iconName: "cup.and.saucer.fill", isSystemIcon: true),
            NATabCategoryItemModel(id: "bakery", title: "Breads &\nCakes", iconName: "birthday.cake.fill", isSystemIcon: true),
            NATabCategoryItemModel(id: "beverages", title: "Juices &\nDrinks", iconName: "wineglass.fill", isSystemIcon: true)
        ]
        
        @State var itemsV1 = [
            NACarouselV1Model(
                title: "Premium Tender Chicken Curry Cut",
                volumeInfo: "500g",
                finishTag: "Freshly Cut",
                currentPrice: 179,
                originalPrice: 220,
                discountText: "18% OFF",
                rating: 4.8,
                ratingCountText: "1.2k ratings",
                productImage: "food",
                isFavorite: false,
                quantity: 0,
                hasOptions: false,
                promotionText: "Buy 1/2 kg, get 1 egg FREE!"
            ),
            
            NACarouselV1Model(
                title: "Lean Mutton Curry Cut (Bone-in)",
                volumeInfo: "500g",
                finishTag: "Premium Halal",
                currentPrice: 449,
                originalPrice: 499,
                discountText: "10% OFF",
                rating: 4.9,
                ratingCountText: "850 ratings",
                productImage: "food",
                isFavorite: true,
                quantity: 1,
                hasOptions: true,
                promotionText: "Buy 1 kg, get 2 eggs FREE!"
            ),
            
            NACarouselV1Model(
                title: "Country Chicken / Nattu Kozhi",
                volumeInfo: "1kg",
                finishTag: "Skin-on",
                currentPrice: 380,
                originalPrice: 420,
                discountText: "9% OFF",
                rating: 4.7,
                ratingCountText: "420 ratings",
                productImage: "food",
                isFavorite: false,
                quantity: 0,
                hasOptions: false,
                promotionText: "Locally Sourced"
            ),
            
            NACarouselV1Model(
                title: "Fresh Boneless Chicken Breast Platter",
                volumeInfo: "450g",
                finishTag: "Cleaned & Antibiotic-Free",
                currentPrice: 219,
                originalPrice: 260,
                discountText: "15% OFF",
                rating: 4.6,
                ratingCountText: "2.1k ratings",
                productImage: "food",
                isFavorite: false,
                quantity: 0,
                hasOptions: false,
                promotionText: "High Protein Pick"
            )
        ]
        
        @State private var itemsV2 = [
            NAGridViewV3Model(name: "Premium Goat + Chicken Combo", images: ["img1", "img2"], currentPrice: 280, quantity: 1),
            NAGridViewV3Model(name: "Fresh Seafood Special Platter", images: ["img1", "img2"], currentPrice: 340, quantity: 0),
            NAGridViewV3Model(name: "Curry Cut Mutton Family Pack", images: ["img1", "img2"], currentPrice: 450, quantity: 0),
            NAGridViewV3Model(name: "Boneless Breast + Wings", images: ["img1", "img2"], currentPrice: 220, quantity: 0)
        ]
        
        
        var body: some View {
            ScrollView {
                VStack(spacing: 24) {
                    NASpotlightInRowViewV1(
                        title: "Best of Fresh Cuts",
                        subtitle: "Up to 15% OFF",
                        heroImageName: "makeup_hero_group",
                        showTabbar: true,
                        categories: tabbarItems,
                        selectedCategoryId: $selectedTab,
                        onTabSelected: { selected in
                            print("Selected Tab: \(selected.title)")
                        },
                        onClickSeeAll: {
                            print("See All Tapped!")
                        }
                    ) {
                        NACarouselViewV1(
                            items: $itemsV1,
                            cardWidth: 300,
                            imageHeight: 220,
                            detailHeight: 120,
                            cornerRadius: 24,
                            topCardBackgroundColor: Color(red: 20/255, green: 80/255, blue: 50/255),
                            accentColor: Color(red: 226/255, green: 18/255, blue: 73/255),
                            onClickAdd: { item in
                                
                            },
                            onClickRemove: { item in
                               
                            },
                            onClickInitialAdd: { item in
                                
                            },
                            onClickOptions: { item in
                                
                            },
                            onClickPromotion: { item in
                            
                            },
                            onItemTap: { item in
                                
                            }
                        )
                    }
                    
                    NASpotlightInRowViewV1(
                        title: "Daily Specials",
                        subtitle: "Handpicked deals for you",
                        heroImageName: nil,
                        backgroundColor: Color.blue.opacity(0.06),
                        showTabbar: false
                    ) {
                        NAGridViewV3(
                            items: $itemsV2,
                            orientation: .vertical,
                            gridCount: 2,
                            spacing: 10,
                            backgroundColor: Color.green.opacity(0.08),
                            onClickAdd: { item in
                                
                            },
                            onClickRemove: { item in
                                
                            },
                            onClickInitialAdd: { item in
                                
                            },
                            onClickFavourite: { item in
                                
                            },
                            onItemTap: { item in
                               
                            }
                        )
                    }
                }
            }
        }
    }
    
    return PreviewWrapper()
}
