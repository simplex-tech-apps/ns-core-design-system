//
//  NAGridViewV1.swift
//  NammaAppUI
//
//  Created by apple on 31/07/26.
//

import SwiftUI

// MARK: - NAGridViewV1 Model
public struct NAGridViewV1CardModel: Identifiable, Hashable {
    public let id = UUID()
    public let title: String
    public let imageName: String
    public let categoryBadge: String
    public let badgeColor: Color
    public let badgeTextColor: Color
    public let prepTimeMinutes: Int
    public let isVeg: Bool
    public var isBookmarked: Bool
    
    public init(
        title: String,
        imageName: String,
        categoryBadge: String,
        badgeColor: Color,
        badgeTextColor: Color,
        prepTimeMinutes: Int,
        isVeg: Bool = true,
        isBookmarked: Bool = false
    ) {
        self.title = title
        self.imageName = imageName
        self.categoryBadge = categoryBadge
        self.badgeColor = badgeColor
        self.badgeTextColor = badgeTextColor
        self.prepTimeMinutes = prepTimeMinutes
        self.isVeg = isVeg
        self.isBookmarked = isBookmarked
    }
}

public struct NAGridViewV1CardView: View {
    public let item: NAGridViewV1CardModel
    public var onBookmarkTap: (() -> Void)?
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack(alignment: .topTrailing) {
                Image(item.imageName, bundle: .module)
                    .resizable()
                    .scaledToFill()
                    .aspectRatio(1.0, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                
                Button(action: { onBookmarkTap?() }) {
                    Image(systemName: item.isBookmarked ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.black.opacity(0.4))
                        .clipShape(Circle())
                }
                .padding(8)
            }
            
            HStack(spacing: 6) {
                if item.isVeg {
                    ZStack {
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(red: 16/255, green: 120/255, blue: 45/255), lineWidth: 1.5)
                            .frame(width: 14, height: 14)
                        Circle()
                            .fill(Color(red: 16/255, green: 120/255, blue: 45/255))
                            .frame(width: 6, height: 6)
                    }
                }
                
                Text(item.categoryBadge)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(item.badgeTextColor)
                    .padding(4)
                    .background(item.badgeColor)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            }
            .padding(.top, 2)
            
            Text(item.title)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
            
            HStack(spacing: 4) {
                Image(systemName: "cooktop.fill")
                    .font(.system(size: 11))
                    .foregroundColor(.orange)
                
                Text("\(item.prepTimeMinutes) mins")
                    .font(.system(size: 11, weight: .regular))
                    .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
            }
            
            Spacer()
        }
    }
}

// MARK: - Configurable Food Grid
public enum GridOrientation {
    case vertical
    case horizontal
}

public struct NAGridViewV1: View {
    public let items: [NAGridViewV1CardModel]
    public let orientation: GridOrientation
    public let gridCount: Int
    public let spacing: CGFloat
    
    public init(
        items: [NAGridViewV1CardModel],
        orientation: GridOrientation = .horizontal,
        gridCount: Int = 3,
        spacing: CGFloat = 12
    ) {
        self.items = items
        self.orientation = orientation
        self.gridCount = gridCount
        self.spacing = spacing
    }
    
    private var gridItems: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: spacing), count: max(1, gridCount))
    }
    
    public var body: some View {
        Group {
            switch orientation {
            case .vertical:
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: gridItems, alignment: .leading, spacing: spacing) {
                        ForEach(items) { recipe in
                            NAGridViewV1CardView(item: recipe)
                        }
                    }
                    .padding(.horizontal, 12)
                }
                
            case .horizontal:
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: gridItems, alignment: .top, spacing: spacing) {
                        ForEach(items) { recipe in
                            NAGridViewV1CardView(item: recipe)
                        }
                    }
                    .padding(.horizontal, 12)
                }
            }
        }
    }
}

struct NAGridViewV1DemoScreen: View {
    @State private var orientation: GridOrientation = .vertical
    @State private var gridCount: Int = 3
    
    let sampleData: [NAGridViewV1CardModel] = [
        NAGridViewV1CardModel(
            title: "Kuzhambu",
            imageName: "food",
            categoryBadge: "Gluten",
            badgeColor: Color(red: 254/255, green: 232/255, blue: 212/255),
            badgeTextColor: Color(red: 210/255, green: 110/255, blue: 40/255),
            prepTimeMinutes: 40
        ),
        NAGridViewV1CardModel(
            title: "Ridge Gourd Kootu Anand",
            imageName: "food",
            categoryBadge: "Main Course",
            badgeColor: Color(red: 228/255, green: 244/255, blue: 244/255),
            badgeTextColor: Color(red: 16/255, green: 120/255, blue: 130/255),
            prepTimeMinutes: 30
        ),
        NAGridViewV1CardModel(
            title: "Lemon Rice",
            imageName: "food",
            categoryBadge: "Main Course",
            badgeColor: Color(red: 228/255, green: 244/255, blue: 244/255),
            badgeTextColor: Color(red: 16/255, green: 120/255, blue: 130/255),
            prepTimeMinutes: 15
        ),
        NAGridViewV1CardModel(
            title: "Egg Biryani",
            imageName: "food",
            categoryBadge: "Main Course",
            badgeColor: Color(red: 228/255, green: 244/255, blue: 244/255),
            badgeTextColor: Color(red: 16/255, green: 120/255, blue: 130/255),
            prepTimeMinutes: 60
        ),
        NAGridViewV1CardModel(
            title: "Masala Uttapam",
            imageName: "food",
            categoryBadge: "Vegan",
            badgeColor: Color(red: 220/255, green: 245/255, blue: 220/255),
            badgeTextColor: Color(red: 30/255, green: 140/255, blue: 40/255),
            prepTimeMinutes: 30
        ),
        NAGridViewV1CardModel(
            title: "Beans Kootu",
            imageName: "food",
            categoryBadge: "Tamil",
            badgeColor: Color(red: 254/255, green: 232/255, blue: 212/255),
            badgeTextColor: Color(red: 210/255, green: 110/255, blue: 40/255),
            prepTimeMinutes: 30
        )
    ]
    
    var body: some View {
        NAGridViewV1(
            items: sampleData,
            orientation: orientation,
            gridCount: gridCount,
            spacing: 12
        )
    }
}

// MARK: - Preview
#Preview {
    NAGridViewV1DemoScreen()
}
