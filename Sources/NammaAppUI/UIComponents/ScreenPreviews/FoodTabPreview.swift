//
//  FishTabView.swift
//  NammaAppUI
//
//  Created by apple on 22/07/26.
//

import SwiftUI

struct FoodTabPreview: View {
    @State
    private var appTheme = AppThemeManager.shared
    
    let sampleShops = [
        NAShopCardViewV2Model(
            imageName: "paneer_thali",
            discountText: "70% off upto ₹130",
            deliveryTime: "25-30 MINS",
            isBolt: true,
            boltSubtitle: "Food in 10-15 min",
            tagBadgeText: "Pure Veg",
            isVeg: true,
            shopName: "ITC Aashirvaad Soul Creations",
            rating: 4.3,
            ratingCountText: "3.3K+",
            location: "Ramapuram",
            distance: "1.3 km",
            cuisines: "Indian, pure veg",
            costForTwo: "₹500 for two",
            isAd: true
        ),
        NAShopCardViewV2Model(
            imageName: "kfc_burger",
            discountText: "50% off",
            deliveryTime: "30-40 MINS",
            isBolt: true,
            boltSubtitle: "Food in 10-15 min",
            tagBadgeText: "Best in Bolt",
            isVeg: false,
            shopName: "KFC",
            rating: 3.9,
            ratingCountText: "30K+",
            location: "Ramapuram",
            distance: "1.8 km",
            cuisines: "Burgers, Fast Food",
            costForTwo: "₹400 for two"
        ),
        NAShopCardViewV2Model(
            imageName: "kfc_burger",
            discountText: "50% off",
            deliveryTime: "30-40 MINS",
            isBolt: true,
            boltSubtitle: "Food in 10-15 min",
            tagBadgeText: "Best in Bolt",
            isVeg: false,
            shopName: "KFC",
            rating: 3.9,
            ratingCountText: "30K+",
            location: "Ramapuram",
            distance: "1.8 km",
            cuisines: "Burgers, Fast Food",
            costForTwo: "₹400 for two"
        ),
        NAShopCardViewV2Model(
            imageName: "kfc_burger",
            discountText: "50% off",
            deliveryTime: "30-40 MINS",
            isBolt: true,
            boltSubtitle: "Food in 10-15 min",
            tagBadgeText: "Best in Bolt",
            isVeg: false,
            shopName: "KFC",
            rating: 3.9,
            ratingCountText: "30K+",
            location: "Ramapuram",
            distance: "1.8 km",
            cuisines: "Burgers, Fast Food",
            costForTwo: "₹400 for two"
        ),
        NAShopCardViewV2Model(
            imageName: "kfc_burger",
            discountText: "50% off",
            deliveryTime: "30-40 MINS",
            isBolt: true,
            boltSubtitle: "Food in 10-15 min",
            tagBadgeText: "Best in Bolt",
            isVeg: false,
            shopName: "KFC",
            rating: 3.9,
            ratingCountText: "30K+",
            location: "Ramapuram",
            distance: "1.8 km",
            cuisines: "Burgers, Fast Food",
            costForTwo: "₹400 for two"
        ),
        NAShopCardViewV2Model(
            imageName: "kfc_burger",
            discountText: "50% off",
            deliveryTime: "30-40 MINS",
            isBolt: true,
            boltSubtitle: "Food in 10-15 min",
            tagBadgeText: "Best in Bolt",
            isVeg: false,
            shopName: "KFC",
            rating: 3.9,
            ratingCountText: "30K+",
            location: "Ramapuram",
            distance: "1.8 km",
            cuisines: "Burgers, Fast Food",
            costForTwo: "₹400 for two"
        ),
        NAShopCardViewV2Model(
            imageName: "kfc_burger",
            discountText: "50% off",
            deliveryTime: "30-40 MINS",
            isBolt: true,
            boltSubtitle: "Food in 10-15 min",
            tagBadgeText: "Best in Bolt",
            isVeg: false,
            shopName: "KFC",
            rating: 3.9,
            ratingCountText: "30K+",
            location: "Ramapuram",
            distance: "1.8 km",
            cuisines: "Burgers, Fast Food",
            costForTwo: "₹400 for two"
        ),
        NAShopCardViewV2Model(
            imageName: "kfc_burger",
            discountText: "50% off",
            deliveryTime: "30-40 MINS",
            isBolt: true,
            boltSubtitle: "Food in 10-15 min",
            tagBadgeText: "Best in Bolt",
            isVeg: false,
            shopName: "KFC",
            rating: 3.9,
            ratingCountText: "30K+",
            location: "Ramapuram",
            distance: "1.8 km",
            cuisines: "Burgers, Fast Food",
            costForTwo: "₹400 for two"
        ),
        NAShopCardViewV2Model(
            imageName: "kfc_burger",
            discountText: "50% off",
            deliveryTime: "30-40 MINS",
            isBolt: true,
            boltSubtitle: "Food in 10-15 min",
            tagBadgeText: "Best in Bolt",
            isVeg: false,
            shopName: "KFC",
            rating: 3.9,
            ratingCountText: "30K+",
            location: "Ramapuram",
            distance: "1.8 km",
            cuisines: "Burgers, Fast Food",
            costForTwo: "₹400 for two"
        )
    ]
    
    var body: some View {
        List {
            ForEach(sampleShops) { shop in
                NAShopCardViewV2() {
                    
                }
            }
        }
        .listStyle(.plain)
        .listRowSpacing(0)
    }
}

// MARK: - Preview Setup Engine
#Preview {
    FoodTabPreview()
}
