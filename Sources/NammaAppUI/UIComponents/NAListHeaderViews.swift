//
//  NAListHeaderViews.swift
//  NammaAppUI
//
//  Created by apple on 22/07/26.
//

import SwiftUI

// MARK: - Header Style Models
enum HeaderStyle {
    case standard(title: String, subtitle: String? = nil)
    case seeAll(title: String, actionTitle: String = "View All", onAction: () -> Void)
    case searchBar(placeholder: String, searchText: Binding<String>, onSearchTap: (() -> Void)? = nil)
    case segmentedFilter(title: String, categories: [String], selectedIndex: Binding<Int>)
    case highlighted(title: String, subtitle: String)
}

// MARK: - Reusable Master Header View
struct ReusableHeaderView: View {
    let style: HeaderStyle
    
    var body: some View {
        switch style {
        case .standard(let title, let subtitle):
            StandardHeaderView(title: title, subtitle: subtitle)
            
        case .seeAll(let title, let actionTitle, let onAction):
            SeeAllHeaderView(title: title, actionTitle: actionTitle, onAction: onAction)
            
        case .searchBar(let placeholder, let searchText, let onSearchTap):
            SearchBarHeaderView(placeholder: placeholder, searchText: searchText, onSearchTap: onSearchTap)
            
        case .segmentedFilter(let title, let categories, let selectedIndex):
            SegmentedFilterHeaderView(title: title, categories: categories, selectedIndex: selectedIndex)
            
        case .highlighted(title: let title, subtitle: let subtitle):
            HighlightedHeaderView(title: title, subtitle: subtitle)
        }
    }
}

struct StandardHeaderView: View {
    let title: String
    var subtitle: String? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.primary)
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.secondary)
            }
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

struct HighlightedHeaderView: View {
    let title: String
    var subtitle: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(.black)
            
            HStack(spacing: 12) {
                LinearGradient(
                    colors: [.clear, .black.opacity(0.15)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(height: 1)
                
                Text(subtitle)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
                    .offset(y: 1)
                
                LinearGradient(
                    colors: [.black.opacity(0.15), .clear],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(height: 1)
            }
            .padding(.horizontal, 12)
        }
    }
}

struct SeeAllHeaderView: View {
    let title: String
    var actionTitle: String = "View All"
    let onAction: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.primary)
            
            Spacer()
            
            Button(action: onAction) {
                HStack(spacing: 4) {
                    Text(actionTitle)
                        .font(.system(size: 13, weight: .semibold))
                    Image(systemName: "chevron.right")
                        .font(.system(size: 10, weight: .bold))
                }
                .foregroundColor(Color(red: 226/255, green: 18/255, blue: 73/255))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

struct SearchBarHeaderView: View {
    let placeholder: String
    @Binding var searchText: String
    var onSearchTap: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .font(.system(size: 16, weight: .medium))
            
            TextField(placeholder, text: $searchText)
                .font(.system(size: 14))
                .disabled(onSearchTap != nil)
            
            if !searchText.isEmpty {
                Button(action: { searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal, 16)
        .padding(.vertical, 6)
        .onTapGesture {
            onSearchTap?()
        }
    }
}

struct SegmentedFilterHeaderView: View {
    let title: String
    let categories: [String]
    @Binding var selectedIndex: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(0..<categories.count, id: \.self) { index in
                        Button(action: { selectedIndex = index }) {
                            Text(categories[index])
                                .font(.system(size: 12, weight: .semibold))
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
                                .background(
                                    selectedIndex == index
                                    ? Color(red: 226/255, green: 18/255, blue: 73/255)
                                    : Color(.systemGray6)
                                )
                                .foregroundColor(selectedIndex == index ? .white : .primary)
                                .clipShape(Capsule())
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .padding(.vertical, 8)
    }
}

struct HeaderCatalogDemoView: View {
    @State private var searchText = ""
    @State private var selectedCategoryIndex = 0
    
    let categories = ["All", "Chicken", "Mutton", "Seafood", "Eggs"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ReusableHeaderView(
                    style: .searchBar(
                        placeholder: "Search for items, meat, etc.",
                        searchText: $searchText
                    )
                )

                ReusableHeaderView(
                    style: .seeAll(
                        title: "Top Offers",
                        actionTitle: "See All",
                        onAction: { print("Navigate to all offers") }
                    )
                )

                ReusableHeaderView(
                    style: .segmentedFilter(
                        title: "Explore Categories",
                        categories: categories,
                        selectedIndex: $selectedCategoryIndex
                    )
                )

                ReusableHeaderView(
                    style: .standard(
                        title: "Recommended For You",
                        subtitle: "Fresh cuts delivered in 30 mins"
                    )
                )
            }
            .padding(.vertical, 12)
        }
    }
}
