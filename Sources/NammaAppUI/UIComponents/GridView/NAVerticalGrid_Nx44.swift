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

// MARK: - Pharma Category Model
struct PharmaCategoryItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let productImageName: String // Replace with your isolated asset names
}

// MARK: - Main Grid View
struct PharmaCategoryGridView: View {
    // Mock data mapped precisely to the 4x3 image matrix layout
    let categories: [PharmaCategoryItem] = [
        PharmaCategoryItem(
            title: "Cough, Cold\n& Fever",
            productImageName: "cough_cold"
        ),
        PharmaCategoryItem(
            title: "Vitamin &\nSupplements",
            productImageName: "vitamins"
        ),
        PharmaCategoryItem(
            title: "Pain\nRelief",
            productImageName: "pain_relief"
        ),
        PharmaCategoryItem(
            title: "Elderly\nCare",
            productImageName: "elderly_care"
        ),
        PharmaCategoryItem(
            title: "Ayurveda &\nImmnunity",
            productImageName: "ayurveda"
        ),
        PharmaCategoryItem(
            title: "Stomach\nCare",
            productImageName: "stomach_care"
        ),
        PharmaCategoryItem(
            title: "Derma\nCare",
            productImageName: "derma_care"
        ),
        PharmaCategoryItem(
            title: "Medical\nDevices",
            productImageName: "medical_devices"
        ),
        PharmaCategoryItem(title: "First\nAid", productImageName: "first_aid"),
        PharmaCategoryItem(
            title: "Protein &\nSupplemment",
            productImageName: "protein"
        ),
        PharmaCategoryItem(
            title: "Rehydration & ORS",
            productImageName: "rehydration"
        ),
        PharmaCategoryItem(
            title: "Sexual\nWellness",
            productImageName: "sexual_wellness"
        )
    ]
    
    // 🎯 Strictly configures a 4-column adaptive matrix matching the layout design
    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 12),
        count: 4
    )
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(categories) { category in
                    PharmaCategoryCardView(category: category)
                }
            }
            .padding(.horizontal, 14)
            .padding(.top, 16)
        }
        .background(Color(.systemBackground))
    }
}

// MARK: - Individual Pharma Card Component View
struct PharmaCategoryCardView: View {
    let category: PharmaCategoryItem
    
    // Custom soft gradient styling defined in the reference screenshot
    private var containerGradient: LinearGradient {
        LinearGradient(
            stops: [
                .init(
                    color: Color(red: 238/255, green: 244/255, blue: 252/255),
                    location: 0.0
                ),
                // Light/Soft top tint
                .init(
                    color: Color(red: 220/255, green: 232/255, blue: 248/255),
                    location: 0.5
                ),
                // Mid shading
                .init(
                    color: Color(red: 195/255, green: 215/255, blue: 242/255),
                    location: 1.0
                )  // Darker blue bottom shadow base
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    var body: some View {
        VStack(spacing: 6) {
            // GRADIENT CONTAINER LAYER (Perfect 1:1 Square aspect ratio)
            ZStack {
                // Background surface
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(containerGradient)
                
                // Fine external shadow outline to pop off light view canvas backgrounds
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(Color.black.opacity(0.03), lineWidth: 1)
                
                // Centered Product Group Illustration
                Image(category.productImageName)
                    .resizable()
                    .scaledToFit()
                    .padding(
                        8
                    ) // Keeps the group assets neatly boxed away from corners
            }
            .aspectRatio(
                1.0,
                contentMode: .fit
            ) // Strict square proportions layout constraint
            
            // TYPOGRAPHY LAYER
            Text(category.title)
                .font(.system(size: 13, weight: .medium, design: .default))
                .foregroundColor(
                    Color(red: 44/255, green: 53/255, blue: 71/255)
                ) // Sharp charcoal gray color
                .multilineTextAlignment(.center)
                .lineLimit(2) // Support up to 2 full lines of context
                .frame(
                    height: 34,
                    alignment: .top
                ) // Enforces explicit identical height limits across all items
                .padding(.horizontal, 2)
        }
    }
}

// MARK: - Ailment Category Model
struct AilmentCategoryItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let imageName: String // Replace with your image asset strings
}

// MARK: - Main Grid View
struct AilmentGridView: View {
    // Mock data matching the 2x2 grid layout exactly
    let categories: [AilmentCategoryItem] = [
        AilmentCategoryItem(title: "Headache", imageName: "headache_img"),
        AilmentCategoryItem(title: "Fever", imageName: "fever_img"),
        AilmentCategoryItem(title: "First Aid", imageName: "first_aid_img"),
        AilmentCategoryItem(
            title: "Stomach\nUpset",
            imageName: "stomach_upset_img"
        )
    ]
    
    // 🎯 Configures a symmetric 2-column vertical layout grid
    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 12),
        count: 2
    )
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(categories) { category in
                    AilmentCardView(category: category)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
        .background(Color(.systemBackground))
    }
}

// MARK: - Individual Ailment Card Component
struct AilmentCardView: View {
    let category: AilmentCategoryItem
    
    var body: some View {
        // Main layout split horizontally between action controls (left) and imagery (right)
        HStack(spacing: 0) {
            
            // LEFT BLOCK: Houses Title and the Action Arrow Button
            VStack(alignment: .leading, spacing: 0) {
                Text(category.title)
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(
                        Color(red: 33/255, green: 43/255, blue: 54/255)
                    ) // Deep dark slate text
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .frame(
                        height: 48,
                        alignment: .topLeading
                    ) // Prevents multi-line layout shifts
                
                Spacer(minLength: 12)
                
                // White Circular Arrow Button Panel
                Image(systemName: "arrow.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                    .frame(width: 30, height: 30)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(
                        color: Color.black.opacity(0.05),
                        radius: 2,
                        x: 0,
                        y: 1
                    )
            }
            .padding(.vertical, 16)
            .padding(.leading, 16)
            
            Spacer(minLength: 4)
            
            // RIGHT BLOCK: Renders the category illustration flush to the trailing/bottom edges
            ZStack(alignment: .bottomTrailing) {
                Image(category.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        maxHeight: 110
                    ) // Restrains imagery vertically inside the uniform frame boundaries
            }
        }
        .frame(maxWidth: .infinity)
        .frame(
            height: 120
        ) // Uniform structural frame height for all grid items
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(
                    Color(red: 219/255, green: 233/255, blue: 252/255)
                ) // Signature soft powder-blue background
        )
    }
}

// MARK: - Models
struct BeautyCategory: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let imageName: String
}

struct BeautyProductItem: Identifiable {
    let id = UUID()
    let title: String
    let volumeInfo: String
    let finishTag: String
    let currentPrice: Int
    let originalPrice: Int
    let discountText: String
    let rating: Double
    let ratingCountText: String
    let productImage: String
    var isFavorite: Bool = false
    var quantity: Int = 0
    let hasOptions: Bool
    let promotionText: String? // Handles special offers like "Buy 1 Get 1 Free"
}

// MARK: - Main Master View
struct BeautyCatalogView: View {
    // Top Categories List
    let categories = [
        BeautyCategory(title: "Lipstick", imageName: "lipstick_icon"),
        BeautyCategory(title: "Kajal and\nliner", imageName: "kajal_icon"),
        BeautyCategory(title: "Foundation", imageName: "foundation_icon"),
        BeautyCategory(title: "Nails", imageName: "nails_icon"),
        BeautyCategory(title: "Compact\npowder", imageName: "compact_icon")
    ]
    
    @State private var selectedCategory: String = "Lipstick"
    
    // Product Items State Management
    @State private var products = [
        BeautyProductItem(
            title: "Blue Heaven Intense Matte Lipstick | Plum D...",
            volumeInfo: "1 pc (4 g)",
            finishTag: "Matte Finish",
            currentPrice: 94,
            originalPrice: 110,
            discountText: "₹16 OFF",
            rating: 3.9,
            ratingCountText: "(2k)",
            productImage: "blue_heaven",
            quantity: 1,
            hasOptions: false,
            promotionText: "Buy 1 Get 1 Free"
        ),
        BeautyProductItem(
            title: "Lakme Forever Matte Liquid Lip, 16hr Lipstick, Lig...",
            volumeInfo: "5.6 ml",
            finishTag: "Matte Finish",
            currentPrice: 326,
            originalPrice: 450,
            discountText: "₹124 OFF",
            rating: 4.4,
            ratingCountText: "(1k)",
            productImage: "lakme_liquid",
            quantity: 0,
            hasOptions: true,
            promotionText: nil
        ),
        BeautyProductItem(
            title: "Insight Cosmetics Non Transfer Liquid Lipstick |...",
            volumeInfo: "1 pc (4 ml)",
            finishTag: "SPF 15",
            currentPrice: 121,
            originalPrice: 130,
            discountText: "₹9 OFF",
            rating: 4.1,
            ratingCountText: "(2k)",
            productImage: "insight_lipstick",
            quantity: 0,
            hasOptions: true,
            promotionText: nil
        )
    ]
    
    private let gridRows: [GridItem] = [
        GridItem(.fixed(310), spacing: 16)
    ]
    
    // Top Banner Background Gradient
    private var topBannerGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 255/255, green: 242/255, blue: 236/255),
                Color(red: 254/255, green: 245/255, blue: 242/255)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    @Namespace private var categoryBarNamespace

    var body: some View {
        VStack(spacing: 0) {
            // 1. DYNAMIC HEADER AND HERO SECTION
            VStack(spacing: 0) {
                HStack() {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Beauty products")
                            .font(
                                .system(
                                    size: 28,
                                    weight: .bold,
                                    design: .rounded
                                )
                            )
                            .foregroundColor(
                                Color(red: 145/255, green: 25/255, blue: 32/255)
                            ) // Deep Crimson Red
                        
                        Text("Up to 85% off")
                            .font(
                                .system(
                                    size: 20,
                                    weight: .semibold,
                                    design: .rounded
                                )
                            )
                            .foregroundColor(
                                Color(red: 198/255, green: 92/255, blue: 82/255)
                            ) // Light coral/red
                    }
                    Spacer()
                    
                    // Main Hero Graphic Group (Top Right)
                    Image("makeup_hero_group")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130, height: 95)
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                
                // 2. HORIZONTAL CATEGORY NAVIGATION FILTER BAR
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(categories) { category in
                            VStack(spacing: 8) {
                                Image(category.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 45, height: 45)
                                
                                Text(category.title)
                                    .font(
                                        .system(
                                            size: 13,
                                            weight: category.title == selectedCategory ? .bold : .medium
                                        )
                                    )
                                    .foregroundColor(
                                        category.title == selectedCategory ? .black : .secondary
                                    )
                                    .multilineTextAlignment(.center)
                                    .frame(height: 32, alignment: .top)
                                
                                // Animated Indicator Strip Base
                                ZStack {
                                    if category.title == selectedCategory {
                                        Rectangle()
                                            .fill(Color.black)
                                            .frame(height: 2)
                                        // This binds the rectangle identity to the moving selection state
                                            .matchedGeometryEffect(
                                                id: "activeTabLine",
                                                in: categoryBarNamespace
                                            )
                                    } else {
                                        // Invisible structural placeholder line to prevent vertical text shifting
                                        Rectangle()
                                            .fill(Color.clear)
                                            .frame(height: 2)
                                    }
                                }
                            }
                            .frame(width: 80)
                            .contentShape(
                                Rectangle()
                            ) // Makes the whole slot area interactive
                            .onTapGesture {
                                // Explicit spring animation block creates the smooth sliding movement
                                withAnimation(
                                    .spring(
                                        response: 0.35,
                                        dampingFraction: 0.75
                                    )
                                ) {
                                    selectedCategory = category.title
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .background(topBannerGradient)
            
            // Thin boundary rule splitting header and shelf canvas
            Rectangle()
                .fill(Color.black.opacity(0.08))
                .frame(height: 1)
            
            // 3. PRODUCT HORIZONTAL SCROLL CAROUSEL SHELF
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: gridRows, alignment: .top, spacing: 14) {
                    ForEach($products) { $product in
                        BeautyProductCardView(product: $product)
                            .frame(width: 140)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
            }
            
            Spacer()
        }
        .background(
            Color(red: 253/255, green: 246/255, blue: 243/255)
        ) // Soft skin tone page background tint
    }
}

// MARK: - Individual Product Card View
struct BeautyProductCardView: View {
    @Binding var product: BeautyProductItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // TOP CANVAS IMAGE AREA
            ZStack {
                // 1. Base Product Image
                Image(product.productImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 140, height: 180)
                    .clipped()
                
                // 2. Favorite Heart Pin Button (Explicitly aligned Top-Trailing)
                VStack {
                    HStack {
                        Spacer()
                        Button(action: { product.isFavorite.toggle() }) {
                            Image(
                                systemName: product.isFavorite ? "heart.fill" : "heart"
                            )
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.pink)
                            .padding(8)
                            .background(Color.white.opacity(0.4))
                            .clipShape(Circle())
                        }
                        .padding([.top, .trailing], 8)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // 3. 🎯 DYNAMIC QUANTITY BOX OR ADD BUTTON OVERLAY (Explicitly aligned Bottom-Trailing)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        if product.quantity > 0 {
                            // Incrementor Active Stepper State Panel (`- 1 +`)
                            HStack(spacing: 12) {
                                Button(action: { product.quantity -= 1 }) {
                                    Image(systemName: "minus")
                                        .font(.system(size: 12, weight: .bold))
                                }
                                
                                Text("\(product.quantity)")
                                    .font(.system(size: 12, weight: .bold))
                                
                                Button(action: { product.quantity += 1 }) {
                                    Image(systemName: "plus")
                                        .font(.system(size: 12, weight: .bold))
                                }
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .frame(height: 32)
                            .background(
                                Color(red: 226/255, green: 18/255, blue: 73/255)
                            )
                            .cornerRadius(8)
                            // Offset slightly downward to match custom multi-layer card layouts if needed
                            .padding([.bottom, .trailing], 8)
                            
                        } else {
                            // Default Interactive ADD Trigger
                            Button(action: { product.quantity = 1 }) {
                                VStack(spacing: 0) {
                                    Text("ADD")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(
                                            Color(
                                                red: 226/255,
                                                green: 18/255,
                                                blue: 73/255
                                            )
                                        )
                                    if product.hasOptions {
                                        Text("2 options")
                                            .font(.system(size: 8))
                                            .foregroundColor(.gray)
                                    }
                                }
                                .frame(width: 65, height: 32)
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(
                                            Color(
                                                red: 226/255,
                                                green: 18/255,
                                                blue: 73/255
                                            ),
                                            lineWidth: 1.5
                                        )
                                )
                                .shadow(
                                    color: Color.black.opacity(0.08),
                                    radius: 3,
                                    x: 0,
                                    y: 2
                                )
                            }
                            .padding([.bottom, .trailing], 8)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: 140, height: 180)
            .background(Color.white)
            .cornerRadius(16)
            
            // BOTTOM DETAIL/INFO REGION
            VStack(alignment: .leading, spacing: 5) {
                // Price blocks row
                HStack(alignment: .center, spacing: 6) {
                    Text("₹\(product.currentPrice)")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 3)
                        .background(
                            Color(red: 16/255, green: 110/255, blue: 43/255)
                        ) // Deep Store Green Tag
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    
                    Text("₹\(product.originalPrice)")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                        .strikethrough()
                }
                .padding(.top, 18)
                
                Text(product.discountText)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(
                        Color(red: 16/255, green: 110/255, blue: 43/255)
                    )
                
                Text(product.title)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.black.opacity(0.85))
                    .lineLimit(2)
                    .frame(height: 36, alignment: .topLeading)
                
                // Sizing Volume Information
                Text(product.volumeInfo)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                
                // Finish Type Custom Tag Box
                Text(product.finishTag)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(
                        Color(red: 20/255, green: 110/255, blue: 130/255)
                    )
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Color(red: 232/255, green: 247/255, blue: 250/255)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                
                // Review Scale Rating Row
                HStack(spacing: 3) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 10))
                        .foregroundColor(
                            Color(red: 16/255, green: 110/255, blue: 43/255)
                        )
                    Text(String(format: "%.1f", product.rating))
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.black)
                    Text(product.ratingCountText)
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                }
                .padding(.top, 2)
                
                // CUSTOM CONDITIONAL MULTI-BUY PROMOTION (With Dotted Custom Accent Line)
                if let promo = product.promotionText {
                    Button(action: {}) {
                        HStack(spacing: 3) {
                            Text(promo)
                                .font(.system(size: 11, weight: .bold))
                            Image(systemName: "chevron.right")
                                .font(.system(size: 8, weight: .bold))
                        }
                        .foregroundColor(.blue)
                        .padding(.top, 2)
                        .overlay(
                            // Simulates the clean dotted text underline style
                            LineStylePattern()
                                .stroke(
                                    style: StrokeStyle(
                                        lineWidth: 1,
                                        lineCap: .round,
                                        lineJoin: .miter,
                                        dash: [1, 2]
                                    )
                                )
                                .foregroundColor(.blue)
                                .frame(height: 1)
                                .padding(.top, 16)
                        )
                    }
                }
            }
            .padding(.horizontal, 4)
        }
    }
}

// MARK: - Helper Shape for Dotted Underline Layouts
struct LineStylePattern: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        return path
    }
}

// MARK: - Models
struct BrandCardItem: Identifiable {
    let id = UUID()
    let brandName: String
    let brandLogo: String
    let productImages: [String] // Array of exactly 2 items for the white nested preview cards
}

// MARK: - Main Master Grid View
struct StorefrontView: View {
    // Mock data for the horizontal brand carousel below
    let brands = [
        BrandCardItem(
            brandName: "Biotique",
            brandLogo: "biotique_logo",
            productImages: ["bio_p1", "bio_p2"]
        ),
        BrandCardItem(
            brandName: "BBlunt",
            brandLogo: "bblunt_logo",
            productImages: ["bblunt_p1", "bblunt_p2"]
        ),
        BrandCardItem(
            brandName: "Indica",
            brandLogo: "indica_logo",
            productImages: ["indica_p1", "indica_p2"]
        )
    ]
    
    // Deep dark gradient backdrop for banner background layers
    private var bannerGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 30/255, green: 15/255, blue: 5/255),
                Color(red: 15/255, green: 8/255, blue: 2/255)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                
                // 1. TOP PROMOTIONAL CARD GRID COMPOSITION (ZStack accommodates the floating pill)
                ZStack(alignment: .top) {
                    HStack(spacing: 12) {
                        // LEFT TALL BANNER: "Global Store"
                        ZStack(alignment: .topLeading) {
                            bannerGradient
                            
                            // Visual Product Composite Group (Center/Bottom placed)
                            VStack {
                                Spacer()
                                Image("global_products_group")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal, 8)
                                    .padding(.bottom, 12)
                            }
                            
                            Text("Global Store")
                                .font(
                                    .system(
                                        size: 20,
                                        weight: .bold,
                                        design: .rounded
                                    )
                                )
                                .foregroundColor(.white)
                                .padding([.top, .leading], 16)
                        }
                        .frame(height: 330)
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 24,
                                style: .continuous
                            )
                        )
                        
                        // RIGHT VSTACK PANEL: Two Horizontal Cards Stacked
                        VStack(spacing: 12) {
                            // Top Right Card
                            ZStack(alignment: .topLeading) {
                                bannerGradient
                                
                                HStack {
                                    Spacer()
                                    Image("hommade_products_group")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: 90)
                                        .padding(.trailing, 8)
                                        .padding(.top, 30)
                                }
                                
                                HStack(alignment: .top) {
                                    Text("Dabur\nHommade R...")
                                        .font(
                                            .system(
                                                size: 17,
                                                weight: .bold,
                                                design: .rounded
                                            )
                                        )
                                        .foregroundColor(.white)
                                        .lineLimit(2)
                                    Spacer()
                                    Image("hommade_logo_badge")
                                        .resizable()
                                        .frame(width: 36, height: 36)
                                        .cornerRadius(8)
                                }
                                .padding([.top, .horizontal], 14)
                            }
                            .frame(height: 159)
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 24,
                                    style: .continuous
                                )
                            )
                            
                            // Bottom Right Card
                            ZStack(alignment: .topLeading) {
                                bannerGradient
                                
                                VStack {
                                    Spacer()
                                    Image("cocoa_products_group")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: 85)
                                        .padding(.bottom, 4)
                                }
                                .frame(maxWidth: .infinity)
                                
                                HStack(alignment: .top) {
                                    Text("Dark Cocoa\nAffair")
                                        .font(
                                            .system(
                                                size: 17,
                                                weight: .bold,
                                                design: .rounded
                                            )
                                        )
                                        .foregroundColor(.white)
                                        .lineLimit(2)
                                    Spacer()
                                    Image("bournville_logo_badge")
                                        .resizable()
                                        .frame(width: 36, height: 36)
                                        .cornerRadius(8)
                                }
                                .padding([.top, .horizontal], 14)
                            }
                            .frame(height: 159)
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 24,
                                    style: .continuous
                                )
                            )
                        }
                    }
                    
                    // FLOATING ACCENT: Glassmorphism "Back to top" Pill Button
                    Button(action: {}) {
                        HStack(spacing: 6) {
                            Image(systemName: "arrow.up.circle.fill")
                                .font(.system(size: 16))
                            Text("Back to top")
                                .font(
                                    .system(
                                        size: 13,
                                        weight: .bold,
                                        design: .rounded
                                    )
                                )
                        }
                        .foregroundColor(.black)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(
                            .ultraThinMaterial
                        ) // Blurs background elements underneath dynamically
                        .clipShape(Capsule())
                        .shadow(
                            color: Color.black.opacity(0.08),
                            radius: 4,
                            x: 0,
                            y: 2
                        )
                    }
                    .offset(
                        y: -16
                    ) // Offsets button layout boundaries partially off-card edge lines
                }
                .padding(.top, 16)
                
                // 2. MIDDLE BRAND TITLE HEADER
                Text("Brands for you")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(
                        Color(red: 40/255, green: 40/255, blue: 40/255)
                    )
                    .padding(.horizontal, 4)
                
                // 3. HORIZONTAL BRANDS COLLECTION CAROUSEL SHELF
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 14) {
                        ForEach(brands) { brand in
                            BrandShowcaseCardView(brand: brand)
                                .frame(width: 135)
                        }
                    }
                    .padding(.bottom, 8)
                }
            }
            .padding(.horizontal, 14)
        }
        .background(Color.white)
    }
}

// MARK: - Individual Component Card View
struct BrandShowcaseCardView: View {
    let brand: BrandCardItem
    
    var body: some View {
        VStack(spacing: 0) {
            // Main Top Circle Brand Logo
            Image(brand.brandLogo)
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
                .background(Color.white)
                .clipShape(Circle())
                .padding(.top, 8)
            
            // Core Brand Identifier Label
            Text(brand.brandName)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundColor(
                    Color(red: 50/255, green: 50/255, blue: 50/255)
                )
                .padding(.top, 8)
                .frame(height: 24, alignment: .center)
            
            Spacer(minLength: 12)
            
            // DUAL NESTED SUB-CARDS GRID (Product Previews)
            HStack(spacing: 8) {
                ForEach(brand.productImages, id: \.self) { imgStr in
                    ZStack {
                        Color.white
                        Image(imgStr)
                            .resizable()
                            .scaledToFit()
                            .padding(4)
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
        .frame(height: 145)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(
                    Color(red: 254/255, green: 224/255, blue: 195/255)
                ) // Signature warm cream/apricot shade
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
        PlantCategory(title: "Top Picks", iconName: "fork.knife"),
        PlantCategory(title: "Plants", iconName: "leaf.fill"),
        PlantCategory(
            title: "Cocopeat\n& Vermicompost",
            iconName: "shippingbox.fill"
        ),
        PlantCategory(title: "Planting\nSeeds", iconName: "sprout.fill"),
        PlantCategory(
            title: "Gardening\nTools",
            iconName: "wrench.and.screwdriver.fill"
        )
    ]
    
    @State private var selectedCategory: String = "Cocopeat\n& Vermicompost"
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
                                            weight: selectedCategory == category.title ? .bold : .medium
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
                                    if selectedCategory == category.title {
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
                                    selectedCategory = category.title
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
            Image(concern.imageName)
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
    GreenSanctuaryView()
}










