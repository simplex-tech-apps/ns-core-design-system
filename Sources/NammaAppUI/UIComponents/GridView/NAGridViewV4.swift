//
//  NAHorizontalGrid_NxN_V3.swift
//  NammaAppUI
//
//  Created by apple on 22/07/26.
//

import SwiftUI

// MARK: - Product Model
public struct NAGridViewV4Model: Identifiable, Equatable {
    public let id: UUID
    public let imageName: String
    public let currentPrice: Int
    public let originalPrice: Int
    public let discountText: String
    public let title: String
    public let weightInfo: String
    public var quantity: Int
    public var isFavorite: Bool
    public var isAd: Bool

    public init(
        id: UUID = UUID(),
        imageName: String,
        currentPrice: Int,
        originalPrice: Int,
        discountText: String,
        title: String,
        weightInfo: String,
        quantity: Int = 0,
        isFavorite: Bool = false,
        isAd: Bool = false
    ) {
        self.id = id
        self.imageName = imageName
        self.currentPrice = currentPrice
        self.originalPrice = originalPrice
        self.discountText = discountText
        self.title = title
        self.weightInfo = weightInfo
        self.quantity = quantity
        self.isFavorite = isFavorite
        self.isAd = isAd
    }
}

struct DottedLineShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height / 2))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height / 2))
        return path
    }
}

// MARK: - Dynamic Grid Component
public struct NAGridViewV4: View {
    @Binding public var items: [NAGridViewV4Model]
    public var orientation: NAGridOrientation
    public var gridCount: Int
    public var spacing: CGFloat
    public var backgroundColor: Color

    public var onClickAdd: ((NAGridViewV4Model) -> Void)?
    public var onClickRemove: ((NAGridViewV4Model) -> Void)?
    public var onClickInitialAdd: ((NAGridViewV4Model) -> Void)?
    public var onClickFavourite: ((NAGridViewV4Model) -> Void)?
    public var onItemTap: ((NAGridViewV4Model) -> Void)?

    private var gridRows: [GridItem] {
        Array(
            repeating: GridItem(.fixed(210), spacing: spacing),
            count: max(1, gridCount)
        )
    }

    private var gridColumns: [GridItem] {
        Array(
            repeating: GridItem(.flexible(), spacing: spacing),
            count: max(1, gridCount)
        )
    }

    public init(
        items: Binding<[NAGridViewV4Model]>,
        orientation: NAGridOrientation = .vertical,
        gridCount: Int = 2,
        spacing: CGFloat = 10,
        backgroundColor: Color = Color.green.opacity(0.08),
        onClickAdd: ((NAGridViewV4Model) -> Void)? = nil,
        onClickRemove: ((NAGridViewV4Model) -> Void)? = nil,
        onClickInitialAdd: ((NAGridViewV4Model) -> Void)? = nil,
        onClickFavourite: ((NAGridViewV4Model) -> Void)? = nil,
        onItemTap: ((NAGridViewV4Model) -> Void)? = nil
    ) {
        self._items = items
        self.orientation = orientation
        self.gridCount = max(1, gridCount)
        self.spacing = spacing
        self.backgroundColor = backgroundColor
        self.onClickAdd = onClickAdd
        self.onClickRemove = onClickRemove
        self.onClickInitialAdd = onClickInitialAdd
        self.onClickFavourite = onClickFavourite
        self.onItemTap = onItemTap
    }

    public var body: some View {
        Group {
            if orientation == .horizontal {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: gridRows, alignment: .top, spacing: spacing) {
                        ForEach($items) { $product in
                            NAGridViewV4CardView(
                                product: $product,
                                cardBackgroundColor: backgroundColor,
                                onClickAdd: { onClickAdd?(product) },
                                onClickRemove: { onClickRemove?(product) },
                                onClickInitialAdd: { onClickInitialAdd?(product) },
                                onClickFavourite: { onClickFavourite?(product) }
                            )
                            .frame(width: 110)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                onItemTap?(product)
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: gridColumns, spacing: spacing) {
                        ForEach($items) { $product in
                            NAGridViewV4CardView(
                                product: $product,
                                cardBackgroundColor: backgroundColor,
                                onClickAdd: { onClickAdd?(product) },
                                onClickRemove: { onClickRemove?(product) },
                                onClickInitialAdd: { onClickInitialAdd?(product) },
                                onClickFavourite: { onClickFavourite?(product) }
                            )
                            .contentShape(Rectangle())
                            .onTapGesture {
                                onItemTap?(product)
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                }
            }
        }
    }
}

// MARK: - Card Component
struct NAGridViewV4CardView: View {
    @Binding var product: NAGridViewV4Model
    var cardBackgroundColor: Color

    var onClickAdd: () -> Void
    var onClickRemove: () -> Void
    var onClickInitialAdd: () -> Void
    var onClickFavourite: () -> Void

    private let primaryPink = Color(red: 236/255, green: 18/255, blue: 90/255)
    private let darkGreenBadge = Color(
        red: 16/255,
        green: 110/255,
        blue: 43/255
    )

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack(alignment: .bottomTrailing) {
                ZStack(alignment: .topLeading) {
                    Image(product.imageName, bundle: .module)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .aspectRatio(1.0, contentMode: .fill)
                        .background(cardBackgroundColor)
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 10,
                                style: .continuous
                            )
                        )

                    if product.isAd {
                        Text("Ad")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(.gray.opacity(0.8))
                            .padding(.leading, 6)
                            .padding(.top, 6)
                    }
                }
                .clipShape(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                )

                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            product.isFavorite.toggle()
                            onClickFavourite()
                        }) {
                            Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(primaryPink)
                                .padding(6)
                                .background(Color.white.opacity(0.9))
                                .clipShape(Circle())
                        }
                        .buttonStyle(.plain)
                        .padding(6)
                    }
                    Spacer()
                }

                if product.quantity > 0 {
                    HStack(spacing: 10) {
                        Button(action: {
                            product.quantity -= 1
                            onClickRemove()
                        }) {
                            Image(systemName: "minus")
                                .font(.system(size: 12, weight: .bold))
                        }

                        Text("\(product.quantity)")
                            .font(.system(size: 13, weight: .bold))

                        Button(action: {
                            product.quantity += 1
                            onClickAdd()
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 12, weight: .bold))
                        }
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 6)
                    .frame(height: 30)
                    .background(primaryPink)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                    )
                } else {
                    Button(action: {
                        product.quantity = 1
                        onClickInitialAdd()
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(primaryPink)
                            .frame(width: 30, height: 30)
                            .background(Color.white)
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 8,
                                    style: .continuous
                                )
                            )
                            .overlay(
                                RoundedRectangle(
                                    cornerRadius: 8,
                                    style: .continuous
                                )
                                .strokeBorder(primaryPink, lineWidth: 1.5)
                            )
                            .shadow(
                                color: Color.black.opacity(0.08),
                                radius: 3,
                                x: 0,
                                y: 2
                            )
                    }
                    .buttonStyle(.plain)
                }
            }

            HStack(alignment: .center, spacing: 6) {
                Text("₹\(product.currentPrice)")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 3)
                    .background(darkGreenBadge)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                    )

                Text("₹\(product.originalPrice)")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.gray)
                    .strikethrough()
            }
            .padding(.top, 2)

            HStack(spacing: 6) {
                Text(product.discountText)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(darkGreenBadge)

                DottedLineShape()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [2, 3]))
                    .foregroundColor(Color.gray.opacity(0.3))
                    .frame(height: 1)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(product.title)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(
                        Color(red: 20/255, green: 20/255, blue: 20/255)
                    )
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(height: 34, alignment: .topLeading)

                Text(product.weightInfo)
                    .font(.system(size: 11, weight: .regular))
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Usage Example
struct NAGridViewV4DemoScreen: View {
    @State private var items: [NAGridViewV4Model] = [
        NAGridViewV4Model(
            imageName: "vegetables",
            currentPrice: 35,
            originalPrice: 63,
            discountText: "₹28 OFF",
            title: "Organically Grown Ginger",
            weightInfo: "100 g",
            quantity: 1,
            isFavorite: true
        ),
        NAGridViewV4Model(
            imageName: "vegetables",
            currentPrice: 8,
            originalPrice: 26,
            discountText: "₹18 OFF",
            title: "Chilli Green (Pachchai Mi...)",
            weightInfo: "100 g"
        ),
        NAGridViewV4Model(
            imageName: "vegetables",
            currentPrice: 8,
            originalPrice: 26,
            discountText: "₹18 OFF",
            title: "Chilli Green (Pachchai Mi...)",
            weightInfo: "100 g"
        ),
        NAGridViewV4Model(
            imageName: "vegetables",
            currentPrice: 8,
            originalPrice: 26,
            discountText: "₹18 OFF",
            title: "Chilli Green (Pachchai Mi...)",
            weightInfo: "100 g"
        )
    ]

    var body: some View {
        NAGridViewV4(
            items: $items,
            orientation: .horizontal,
            gridCount: 2,
            spacing: 14,
            backgroundColor: Color.green.opacity(0.08),
            onClickAdd: { item in
                
            },
            onClickRemove: { item in
                
            },
            onClickInitialAdd: { item in
                
            },
            onClickFavourite: { item in
                
            }
        ) { selectedItem in
            
        }
    }
}

#Preview {
    NAGridViewV4DemoScreen()
}

