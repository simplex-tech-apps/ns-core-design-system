//
//  NAGridViewV1.swift
//  NammaAppUI
//
//  Created by apple on 31/07/26.
//

import SwiftUI

// MARK: - Custom Staggered Flow Layout (iOS 16+)
public struct FlowLayout: Layout {
    var spacing: CGFloat
    
    public init(spacing: CGFloat = 8) {
        self.spacing = spacing
    }
    
    public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = flow(subviews: subviews, proposal: proposal)
        return result.size
    }
    
    public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = flow(subviews: subviews, proposal: proposal)
        for (index, point) in result.points.enumerated() {
            subviews[index].place(at: CGPoint(x: bounds.minX + point.x, y: bounds.minY + point.y), proposal: .unspecified)
        }
    }
    
    private func flow(subviews: Subviews, proposal: ProposedViewSize) -> (size: CGSize, points: [CGPoint]) {
        var points: [CGPoint] = []
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var lineHeight: CGFloat = 0
        var maxWidth: CGFloat = 0
        
        let containerWidth = proposal.width ?? .infinity
        
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            
            if currentX + size.width > containerWidth, currentX > 0 {
                currentX = 0
                currentY += lineHeight + spacing
                lineHeight = 0
            }
            
            points.append(CGPoint(x: currentX, y: currentY))
            
            lineHeight = max(lineHeight, size.height)
            currentX += size.width + spacing
            maxWidth = max(maxWidth, currentX)
        }
        
        return (CGSize(width: maxWidth, height: currentY + lineHeight), points)
    }
}

// MARK: - NAGridViewV2 Model
public struct NAStaggeredGridViewV2Model: Identifiable {
    public let id = UUID()
    public let text: String
    public let imageName: String?
    
    public init(text: String, imageName: String? = nil) {
        self.text = text
        self.imageName = imageName
    }
}

// MARK: - Card View (Auto-sizing Pill)
public struct NAStaggeredGridViewV2CardView: View {
    public let item: NAStaggeredGridViewV2Model
    
    public var body: some View {
        HStack(spacing: 6) {
            if let icon = item.imageName {
                Image(systemName: icon)
                    .font(.system(size: 12))
                    .foregroundColor(.orange)
            } else {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            
            Text(item.text)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.black)
                .lineLimit(1)
                .fixedSize()
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.25), lineWidth: 1)
        )
    }
}

// MARK: - Staggered Grid Container
public struct NAStaggeredGridViewV2: View {
    public let items: [NAStaggeredGridViewV2Model]
    public let orientation: GridOrientation
    public let spacing: CGFloat
    
    public init(
        items: [NAStaggeredGridViewV2Model],
        orientation: GridOrientation = .vertical,
        spacing: CGFloat = 10
    ) {
        self.items = items
        self.orientation = orientation
        self.spacing = spacing
    }
    
    public var body: some View {
        Group {
            switch orientation {
            case .vertical:
                ScrollView(.vertical, showsIndicators: false) {
                    FlowLayout(spacing: spacing) {
                        ForEach(items) { item in
                            NAStaggeredGridViewV2CardView(item: item)
                        }
                    }
                    .padding(.vertical, 2)
                    .padding(.horizontal, 12)
                }
                
            case .horizontal:
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: spacing) {
                        ForEach(items) { item in
                            NAStaggeredGridViewV2CardView(item: item)
                        }
                    }
                    .padding(.vertical, 2)
                    .padding(.horizontal, 12)
                }
            }
        }
    }
}

// MARK: - Preview Screen
struct NAStaggeredGridViewV2DemoScreen: View {
    let searchList: [NAStaggeredGridViewV2Model] = [
        NAStaggeredGridViewV2Model(text: "salt", imageName: nil),
        NAStaggeredGridViewV2Model(text: "mango", imageName: "leaf.fill"),
        NAStaggeredGridViewV2Model(text: "ch", imageName: nil),
        NAStaggeredGridViewV2Model(text: "cha", imageName: nil),
        NAStaggeredGridViewV2Model(text: "chi", imageName: nil),
        NAStaggeredGridViewV2Model(text: "sensodyne paste", imageName: "sparkles"),
        NAStaggeredGridViewV2Model(text: "organic honey", imageName: "leaf.fill"),
        NAStaggeredGridViewV2Model(text: "milk", imageName: nil)
    ]
    
    var body: some View {
        NAStaggeredGridViewV2(
            items: searchList,
            orientation: .vertical,
            spacing: 10
        )
    }
}

#Preview {
    NAStaggeredGridViewV2DemoScreen()
}
