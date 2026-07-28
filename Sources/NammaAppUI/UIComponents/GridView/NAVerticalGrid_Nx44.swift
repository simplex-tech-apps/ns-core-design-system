//
//  NAVerticalScroll(Nx4).swift
//  NammaAppUI
//
//  Created by apple on 19/07/26.
//

import SwiftUI

// MARK: - Category Model
struct QuickCommerceCategory: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let imageName: String
}

// MARK: - Main Grid View
public struct NAVerticalGrid_Nx4: View {
    // Mock data matching the image layout matrix
    let categories: [QuickCommerceCategory] = [
        QuickCommerceCategory(
            title: "Cold Drinks & more",
            imageName: "cup.and.saucer.fill"
        ),
        QuickCommerceCategory(
            title: "Munchies & more",
            imageName: "takeoutbag.and.cup.and.straw.fill"
        ),
        QuickCommerceCategory(
            title: "Ice creams & more",
            imageName: "birthday.cake.fill"
        ),
        QuickCommerceCategory(
            title: "Chocolates & Cakes",
            imageName: "gift.fill"
        ),
        QuickCommerceCategory(
            title: "Noodles & more",
            imageName: "fork.knife"
        ),
        QuickCommerceCategory(title: "Frozen\nSnacks", imageName: "snowflake"),
        QuickCommerceCategory(
            title: "Game Ready",
            imageName: "gamecontroller.fill"
        ),
        QuickCommerceCategory(title: "Paan Corner", imageName: "leaf.fill")
    ]
    
    // Set up a 4-column adaptive layout with custom item spacing
    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 8),
        count: 4
    )
    
    public var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(categories) { category in
                    CategoryCardView(category: category)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
        .background(
            Color(.systemBackground)
        ) // Adapts to Light/Dark mode automatically
    }
}

// MARK: - Individual Card Item View
struct CategoryCardView: View {
    let category: QuickCommerceCategory
    
    var body: some View {
        VStack(spacing: 0) {
            // Title block section fixed at the top of the card
            Text(category.title)
                .font(.system(size: 11, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .frame(
                    height: 44,
                    alignment: .top
                )
                .padding(.horizontal, 6)
                .padding(.top, 12)
            
            Spacer(minLength: 8)
            
            // Container for item product illustrations
            // Replace Image(systemName:) with your custom multi-item asset layouts as needed
            Image(systemName: category.imageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(.white.opacity(0.9))
                .frame(maxHeight: 75)
                .padding(.horizontal, 8)
                .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity)
        .frame(
            height: 120
        ) // Fixed proportional layout height matching the reference image aspect
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(
                    Color(red: 29/255, green: 78/255, blue: 137/255)
                )
        )
    }
}

// MARK: - Brand Product Model
struct BrandProductItem: Identifiable, Hashable {
    let id = UUID()
    let productImageName: String // Replace with your main product asset string
    let brandLogoImageName: String // Replace with your logo asset string
}
 
// MARK: - Main Grid View
struct NAHorizontalGrid_2xN: View {
    // Mock data matching the brand collection array
    let items: [BrandProductItem] = [
        BrandProductItem(
            productImageName: "coke_can",
            brandLogoImageName: "coke_logo"
        ),
        BrandProductItem(
            productImageName: "lays_pack",
            brandLogoImageName: "lays_logo"
        ),
        BrandProductItem(
            productImageName: "cookies_pack",
            brandLogoImageName: "bakers_logo"
        ),
        BrandProductItem(
            productImageName: "bingo_pack",
            brandLogoImageName: "bingo_logo"
        ),
        BrandProductItem(
            productImageName: "hocco_box",
            brandLogoImageName: "hocco_logo"
        ),
        BrandProductItem(
            productImageName: "chips_pack",
            brandLogoImageName: "popcorn_logo"
        ),
        BrandProductItem(
            productImageName: "fabelle_box",
            brandLogoImageName: "fabelle_logo"
        ),
        BrandProductItem(
            productImageName: "cerelac_pack",
            brandLogoImageName: "cerelac_logo"
        )
    ]
    
    // Configures exactly 2 fixed-height horizontal rows
    private let rows = [
        GridItem(.fixed(155), spacing: 16),
        GridItem(.fixed(155), spacing: 16)
    ]
    
    var body: some View {
        // Changes scroll axis to horizontal
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, spacing: 12) {
                ForEach(items) { item in
                    BrandProductCardView(item: item)
                        .frame(
                            width: 105
                        ) // 🎯 Locks the card width so it scrolls cleanly sideways
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        .background(Color(.systemBackground))
    }
}

// MARK: - Split-Panel Brand Card View
struct BrandProductCardView: View {
    let item: BrandProductItem
    
    var body: some View {
        VStack(spacing: 0) {
            // TOP PANEL: Deep Blue background housing the product image
            ZStack {
                Color(red: 29/255, green: 78/255, blue: 137/255)
                
                Image(item.productImageName)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 10)
                    .padding(.vertical, 12)
            }
            .frame(height: 110)
            
            // BOTTOM PANEL: Soft Cream background housing the brand logo
            ZStack {
                Color(red: 253/255, green: 242/255, blue: 238/255)
                
                Image(item.brandLogoImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 30)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 4)
            }
            .frame(height: 45)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.black.opacity(0.8), lineWidth: 1.5)
        )
    }
}

import SwiftUI

// MARK: - Promo Model
struct AdPromoItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
    let imageAsset: String
    let accentColor: Color
}

struct BrandCarouselView: View {
    let promoItems = [
        AdPromoItem(
            title: "Liss Unlimited",
            subtitle: "Up to 10% OFF",
            imageAsset: "loreal_purple",
            accentColor: Color(red: 175/255, green: 80/255, blue: 90/255)
        ),
        AdPromoItem(
            title: "L'Oréal Professionnel",
            subtitle: "Up to 10% OFF",
            imageAsset: "loreal_products_showcase",
            accentColor: Color(red: 161/255, green: 132/255, blue: 89/255)
        ),
        AdPromoItem(
            title: "Absolut Repair",
            subtitle: "Up to 15% OFF",
            imageAsset: "loreal_orange",
            accentColor: Color(red: 215/255, green: 95/255, blue: 20/255)
        )
    ]
    
    @State private var activeScrollID: UUID?
    
    var body: some View {
        GeometryReader { outerGeometry in
            let screenWidth = outerGeometry.size.width
            let cardWidth: CGFloat = 320
            let cardHeight: CGFloat = 360 // 240 + 120 total inner card components height
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 8) {
                    ForEach(promoItems) { item in
                        GeometryReader { cardGeometry in
                            let midX = cardGeometry.frame(in: .global).midX
                            let screenMidX = screenWidth / 2
                            
                            let distanceFromCenter = abs(screenMidX - midX)
                            
                            let rawScale = 1.0 - (
                                distanceFromCenter / screenWidth
                            ) * 0.4
                            let activeScale = max(0.90, min(1.0, rawScale))
                            
                            let activeOpacity = max(
                                0.6,
                                min(
                                    1.0,
                                    1.0 - (
                                        distanceFromCenter / screenWidth
                                    ) * 0.5
                                )
                            )
                            
                            CarouselPromoCard(item: item)
                                .scaleEffect(activeScale)
                                .opacity(activeOpacity)
                                .animation(
                                    .interactiveSpring(
                                        response: 0.35,
                                        dampingFraction: 0.8
                                    ),
                                    value: distanceFromCenter
                                )
                        }
                        .frame(
                            width: cardWidth,
                            height: cardHeight
                        ) // 🎯 Locks explicit frame layout bounds for geometry layout
                        .id(item.id)
                    }
                }
                .padding(.horizontal, (screenWidth - cardWidth) / 2)
                // Added explicit vertical padding on the inner layout track.
                // This gives the 1.0 scaled card shadow ~16pt of extra room on top and bottom so it doesn't clip.
                .padding(.vertical, 16)
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $activeScrollID)
            // The parent frame accommodates the inner card height + our vertical padding buffers (360 + 32)
            .frame(height: cardHeight + 32)
        }
        .frame(height: 392)
    }
}

// MARK: - Individual Component Layout Card
struct CarouselPromoCard: View {
    let item: AdPromoItem
    
    var body: some View {
        VStack(spacing: 0) {
            // Top Image Window (Independently Rounded at Top)
            ZStack {
                Color(red: 247/255, green: 246/255, blue: 242/255)
                
                Image(item.imageAsset)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 240)
                    .clipped()
            }
            .frame(height: 240)
            // Ensures inner top layout has matching rounding rules
            .clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: 32,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 32,
                    style: .continuous
                )
            )
            
            // Bottom Information Section Block (Independently Rounded at Bottom)
            ZStack(alignment: .bottomTrailing) {
                item.accentColor
                VStack(spacing: 4) {
                    Text(item.title)
                        .font(
                            .system(size: 25, weight: .bold, design: .rounded)
                        )
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Text(item.subtitle)
                        .font(
                            .system(
                                size: 18,
                                weight: .semibold,
                                design: .rounded
                            )
                        )
                        .foregroundColor(.white.opacity(0.9))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(
                    .top,
                    38
                ) // Increased to completely clear the half-hanged circle footprint
                .padding(.horizontal, 16)
                
                // Active Ad Attribution Badge Tag
                Text("Ad")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.black.opacity(0.4))
                    .cornerRadius(4)
                    .padding([.bottom, .trailing], 12)
            }
            .frame(height: 120)
            // Ensures inner bottom layout has matching rounding rules
            .clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 32,
                    bottomTrailingRadius: 32,
                    topTrailingRadius: 0,
                    style: .continuous
                )
            )
            // OVERLAY ATTACHED HERE: Hangs half above the top edge line of this section block
            .overlay(
                Circle()
                    .fill(Color.white)
                    .frame(width: 76, height: 76)
                    .overlay(
                        Image("loreal_brand_logo") // Replace with logo asset
                            .resizable()
                            .scaledToFit()
                            .padding(10)
                    )
                // Negative half-height offset shifts it cleanly over the dividing seam
                    .offset(y: -38),
                alignment: .top
            )
        }
        .frame(width: 320)
        .background(Color.clear)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Models
struct PlantCategory: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let iconName: String
}

struct PlantProductItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let currentPrice: Int
    let originalPrice: Int
    let discountText: String
    let sizeText: String
    let deliveryTime: String
    let stockStatus: String?
    let imageAsset: String
    let tags: [String]
    let navigationText: String
    var isFavorite: Bool = false
    var quantity: Int = 0
    let hasOptions: Bool
    let isTopRated: Bool
}

// MARK: - Main Master Screen View
struct GreenSanctuaryView: View {
    // Top Horizontal Categories
    let categories = [
        PlantCategory(title: "Namma\nShop", iconName: "fork.knife"),
        PlantCategory(title: "Fresh", iconName: "leaf.fill"),
        PlantCategory(title: "Meat",iconName: "shippingbox.fill"),
        PlantCategory(title: "Fish", iconName: "sprout.fill"),
        PlantCategory(title: "Food",iconName: "wrench.and.screwdriver.fill")
    ]
    
    @State private var activeCategory: String = "Cocopeat\n& Vermicompost"
    @Namespace private var categoryBarNamespace
    
    // Product Items State Matrix matching the dynamic video views
    @State private var products = [
        PlantProductItem(
            title: "TrustBasket",
            subtitle: "TrustBasket 100% Organic Vermicompost",
            currentPrice: 85,
            originalPrice: 329,
            discountText: "Price Drop",
            sizeText: "1 kg",
            deliveryTime: "12 mins",
            stockStatus: "3k+ sold last week",
            imageAsset: "vermi_1",
            tags: [],
            navigationText: "All Gardening",
            isFavorite: false,
            quantity: 0,
            hasOptions: false,
            isTopRated: false
        ),
        PlantProductItem(
            title: "Ugaoo",
            subtitle: "Ugaoo Vermicompost Fertilizer for Plants",
            currentPrice: 130,
            originalPrice: 499,
            discountText: "Price Drop",
            sizeText: "2 kg",
            deliveryTime: "12 mins",
            stockStatus: "2k+ sold last week",
            imageAsset: "vermi_2",
            tags: [],
            navigationText: "All Gardening",
            isFavorite: false,
            quantity: 0,
            hasOptions: false,
            isTopRated: false
        ),
        PlantProductItem(
            title: "Kyari",
            subtitle: "Kyari Organic Vermicompost Fertilizer",
            currentPrice: 64,
            originalPrice: 149,
            discountText: "₹85 OFF",
            sizeText: "1 kg",
            deliveryTime: "12 mins",
            stockStatus: nil,
            imageAsset: "vermi_3",
            tags: [],
            navigationText: "All Gardening",
            isFavorite: false,
            quantity: 0,
            hasOptions: true,
            isTopRated: false
        )
    ]
    
    // Layout Background Gradient Theme
    private var topBannerGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 220/255, green: 240/255, blue: 215/255),
                Color(red: 242/255, green: 249/255, blue: 238/255)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    var body: some View {
        VStack(spacing: 0) {
            // 1. DYNAMIC HEADER BLOCK
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Grow your\ngreen sanctuary")
                            .font(
                                .system(
                                    size: 28,
                                    weight: .bold,
                                    design: .rounded
                                )
                            )
                            .foregroundColor(
                                Color(red: 25/255, green: 70/255, blue: 30/255)
                            )
                            .lineSpacing(2)
                        
                        Text("Everything for a relaxing space")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    
                    // Header Corner Illustration Accent
                    Image(systemName: "hand.holding.sprout.fill")
                        .font(.system(size: 45))
                        .foregroundColor(
                            Color(red: 50/255, green: 120/255, blue: 60/255)
                        )
                        .opacity(0.3)
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)
                
                // 2. HORIZONTAL SELECTOR (With Animated Snap Boundaries)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(categories) { category in
                            VStack(spacing: 6) {
                                // Rounded Circle Icon Surface
                                ZStack {
                                    Circle()
                                        .fill(
                                            Color(
                                                red: 205/255,
                                                green: 235/255,
                                                blue: 195/255
                                            )
                                        )
                                        .frame(width: 56, height: 56)
                                    
                                    Image(systemName: category.iconName)
                                        .font(.system(size: 22))
                                        .foregroundColor(
                                            Color(
                                                red: 35/255,
                                                green: 90/255,
                                                blue: 45/255
                                            )
                                        )
                                }
                                
                                Text(category.title)
                                    .font(
                                        .system(
                                            size: 12,
                                            weight: activeCategory == category.title ? .bold : .medium
                                        )
                                    )
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                                    .frame(height: 32, alignment: .top)
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 8)
                            .background(
                                ZStack {
                                    if activeCategory == category.title {
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(
                                                Color(
                                                    red: 45/255,
                                                    green: 115/255,
                                                    blue: 55/255
                                                ),
                                                lineWidth: 1.5
                                            )
                                            .background(
                                                RoundedRectangle(
                                                    cornerRadius: 16
                                                )
                                                .fill(Color.white.opacity(0.3))
                                            )
                                            .matchedGeometryEffect(
                                                id: "activeCategoryBorder",
                                                in: categoryBarNamespace
                                            )
                                    }
                                }
                            )
                            .onTapGesture {
                                withAnimation(
                                    .spring(
                                        response: 0.3,
                                        dampingFraction: 0.75
                                    )
                                ) {
                                    activeCategory = category.title
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
            }
            .background(topBannerGradient)
            
            // 3. HORIZONTAL PRODUCT CATALOG SHELF
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach($products) { $product in
                        PlantProductCardView(product: $product)
                            .frame(width: 155)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
            }
            
            Spacer()
        }
        .background(Color(red: 248/255, green: 252/255, blue: 245/255))
    }
}

// MARK: - Individual Product Card Component
struct PlantProductCardView: View {
    @Binding var product: PlantProductItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // TOP AREA: Image Canvas & Floating Controls
            ZStack {
                // Background Tile
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color(red: 242/255, green: 246/255, blue: 240/255))
                
                // Main Graphic Content
                Image(systemName: product.imageAsset)
                    .font(.system(size: 60))
                    .foregroundColor(
                        Color(red: 55/255, green: 110/255, blue: 65/255)
                    )
                    .frame(width: 155, height: 140)
                
                // Top Rated Badge Overlay
                if product.isTopRated {
                    VStack {
                        HStack {
                            Text("Top Rated")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 3)
                                .background(
                                    Color(
                                        red: 20/255,
                                        green: 85/255,
                                        blue: 45/255
                                    )
                                )
                                .clipShape(
                                    UnevenRoundedRectangle(
                                        topLeadingRadius: 16,
                                        bottomLeadingRadius: 0,
                                        bottomTrailingRadius: 8,
                                        topTrailingRadius: 0
                                    )
                                )
                            Spacer()
                        }
                        Spacer()
                    }
                }
                
                // Favorite Heart Anchor
                VStack {
                    HStack {
                        Spacer()
                        Button(action: { product.isFavorite.toggle() }) {
                            Image(
                                systemName: product.isFavorite ? "heart.fill" : "heart"
                            )
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.gray.opacity(0.8))
                            .padding(6)
                        }
                    }
                    Spacer()
                }
                
                // Bottom Layer Splitting Variant Tag & ADD Matrix Control
                VStack {
                    Spacer()
                    HStack(alignment: .bottom) {
                        // Size/Weight Option Indicator
                        Text(product.sizeText)
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.primary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.white)
                            .cornerRadius(6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(
                                        Color.gray.opacity(0.2),
                                        lineWidth: 0.8
                                    )
                            )
                            .padding(.leading, 8)
                            .padding(.bottom, 8)
                        
                        Spacer()
                        
                        ZStack {
                            if product.quantity > 0 {
                                HStack(spacing: 0) {
                                    Button(action: { product.quantity += 1 }) {
                                        Image(systemName: "plus")
                                            .font(
                                                .system(size: 10, weight: .bold)
                                            )
                                    }
                                    .frame(height: 16)
                                    .padding(.leading, 8)
                                    Spacer()
                                    Text("\(product.quantity)")
                                        .font(.system(size: 12, weight: .bold))
                                        .frame(height: 14)
                                    Spacer()
                                    Button(action: { product.quantity -= 1 }) {
                                        Image(systemName: "minus")
                                            .font(
                                                .system(size: 10, weight: .bold)
                                            )
                                    }
                                    .frame(height: 16)
                                    .padding(.trailing, 8)
                                }
                                .foregroundColor(.white)
                                .frame(width:60, height: 34)
                                .background(
                                    Color(
                                        red: 45/255,
                                        green: 115/255,
                                        blue: 55/255
                                    )
                                )
                                .cornerRadius(8)
                            } else {
                                Button(action: { product.quantity = 1 }) {
                                    VStack(spacing: 1) {
                                        Text("ADD")
                                            .font(
                                                .system(size: 12, weight: .bold)
                                            )
                                            .foregroundColor(
                                                Color(
                                                    red: 45/255,
                                                    green: 115/255,
                                                    blue: 55/255
                                                )
                                            )
                                        if product.hasOptions {
                                            Text("2 options")
                                                .font(.system(size: 7))
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    .frame(width: 44, height: 34)
                                    .background(Color.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(
                                                Color(
                                                    red: 45/255,
                                                    green: 115/255,
                                                    blue: 55/255
                                                ),
                                                lineWidth: 1
                                            )
                                    )
                                }
                            }
                        }
                        .padding(.trailing, 8)
                        .padding(.bottom, 8)
                    }
                }
            }
            .frame(width: 155, height: 140)
            
            // BOTTOM AREA: Details & Metadata Layout
            VStack(alignment: .leading, spacing: 4) {
                // Price Layout Area
                HStack(alignment: .bottom, spacing: 4) {
                    Text("₹\(product.currentPrice)")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                    Text("₹\(product.originalPrice)")
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                        .strikethrough()
                }
                .padding(.top, 8)
                
                // Discount State Flag Label
                Text(product.discountText)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.blue)
                
                // Title and Subtitle Description
                Text(product.title)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Text(product.subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .frame(height: 32, alignment: .topLeading)
                
                // Context Tags (Dynamic arrays e.g., "Indoor")
                if !product.tags.isEmpty {
                    HStack(spacing: 4) {
                        ForEach(product.tags, id: \.self) { tag in
                            Text(tag)
                                .font(.system(size: 10, weight: .medium))
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(4)
                        }
                    }
                    .padding(.vertical, 2)
                }
                
                // Delivery ETA indicator Row
                HStack(spacing: 4) {
                    Image(systemName: "stopwatch.fill")
                        .font(.system(size: 10))
                        .foregroundColor(.secondary)
                    Text(product.deliveryTime)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.secondary)
                    
                    if let status = product.stockStatus {
                        Text("•  \(status)")
                            .font(.system(size: 11))
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                }
                .padding(.top, 2)
                
                // Navigation Link Button Action Row
                Button(action: {}) {
                    HStack(spacing: 2) {
                        Text(product.navigationText)
                            .font(.system(size: 11, weight: .bold))
                        Image(systemName: "play.fill")
                            .font(.system(size: 7))
                    }
                    .foregroundColor(
                        Color(red: 45/255, green: 115/255, blue: 55/255)
                    )
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Color(red: 235/255, green: 247/255, blue: 238/255)
                    )
                    .cornerRadius(6)
                }
                .padding(.top, 6)
            }
            .padding(.horizontal, 4)
        }
    }
}

// MARK: - Concern Category Model
struct ConcernItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String
    let imageName: String // Replace with your image asset strings
}

// MARK: - Main Horizontal Grid View
struct ConcernsHorizontalGridView: View {
    // Mock data matching the specific copy and expanded to show scrolling layout behavior
    let concerns: [ConcernItem] = [
        ConcernItem(
            title: "Acne",
            description: "Skincare infused with salicylic acid, niacinamide & more",
            imageName: "acne_img"
        ),
        ConcernItem(
            title: "Hairfall",
            description: "Strengthen hair roots with rosemary & redensyl",
            imageName: "hairfall_img"
        ),
        ConcernItem(
            title: "Sun Protection",
            description: "SPF enriched with vitamin C, E and hyaluronic acid",
            imageName: "sun_protection_img"
        ),
        
        ConcernItem(
            title: "Dandruff",
            description: "Clear flakes with tea tree oil & ketoconazole",
            imageName: "dandruff_img"
        ),
        ConcernItem(
            title: "Dry Skin",
            description: "Deep hydration with ceramides & hyaluronic acid",
            imageName: "dry_skin_img"
        ),
        ConcernItem(
            title: "Damaged Hair",
            description: "Repair cuticles with argan oil & keratin bonds",
            imageName: "damaged_hair_img"
        )
    ]
    
    // Configures exactly 3 horizontal rows of equal height
    private let rows = Array(
        repeating: GridItem(.fixed(120), spacing: 16),
        count: 3
    )
    
    var body: some View {
        // Standard horizontal scrolling container
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, spacing: 16) {
                ForEach(concerns) { concern in
                    ConcernHorizontalCardView(concern: concern)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
        .background(Color(.systemBackground))
    }
}

// MARK: - Individual Concern Card Component
struct ConcernHorizontalCardView: View {
    let concern: ConcernItem
    
    // Explicit width ensures that the next column partially peeks out on standard screens
    private let cardWidth: CGFloat = 320
    
    var body: some View {
        HStack(spacing: 0) {
            
            // LEFT BLOCK: The Image Asset (Masked with explicit left rounded corners)
            Image("chicken_product", bundle: .module)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipShape(
                    UnevenRoundedRectangle(
                        topLeadingRadius: 28,
                        bottomLeadingRadius: 28,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 0,
                        style: .continuous
                    )
                )
            
            // RIGHT BLOCK: Typography details and the arrow chevron link button
            HStack(alignment: .center, spacing: 10) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(concern.title)
                        .font(
                            .system(
                                size: 17,
                                weight: .semibold,
                                design: .rounded
                            )
                        )
                        .foregroundColor(.black)
                        .lineLimit(1)
                    
                    Text(concern.description)
                        .font(
                            .system(
                                size: 13,
                                weight: .regular,
                                design: .rounded
                            )
                        )
                        .foregroundColor(.gray)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer(minLength: 2)
                
                // Muted Gold/Tan Circular Action Button
                Image(systemName: "chevron.right")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 20, height: 20)
                    .background(
                        Color(red: 212/255, green: 154/255, blue: 79/255)
                    ) // Signature gold accent color
                    .clipShape(Circle())
            }
            .padding(.horizontal, 12)
        }
        .frame(
            width: cardWidth,
            height: 120
        ) // Unified layout bounds across all structural items
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(Color.white)
        )
        .overlay(
            // Micro hair-thin border line around the white layout block
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(Color.black.opacity(0.06), lineWidth: 1)
        )
    }
}

// MARK: - Preview Setup Engine
#Preview {
    ConcernsHorizontalGridView()
}


//Button(action: {}) {
//    HStack(spacing: 6) {
//        Image(systemName: "arrow.up.circle.fill")
//            .font(.system(size: 14))
//        Text("Back to top")
//            .font(
//                .system(
//                    size: 13,
//                    weight: .semibold,
//                    design: .rounded
//                )
//            )
//    }
//    .foregroundColor(.black)
//    .padding(.horizontal, 14)
//    .padding(.vertical, 8)
//    .background(
//        .ultraThinMaterial
//    ) // Blurs background elements underneath dynamically
//    .clipShape(Capsule())
//    .shadow(
//        color: Color.black.opacity(0.08),
//        radius: 4,
//        x: 0,
//        y: 2
//    )
//}







