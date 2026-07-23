//
//  NASpotlightInRowViewV1.swift
//  NammaAppUI
//
//  Created by apple on 20/07/26.
//

import SwiftUI

// MARK: - Main Master View
struct NASpotlightInRowViewV1: View {
    
    private var topBannerGradient: LinearGradient {
        LinearGradient(
            colors: [Color(red: 255/255, green: 242/255, blue: 236/255), Color(red: 254/255, green: 245/255, blue: 242/255)],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    var body: some View {
        VStack(spacing: 12) {
            VStack(spacing: 0) {
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Best of chickens")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 145/255, green: 25/255, blue: 32/255))
                        
                        Text("Up to 10% off")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .foregroundColor(Color(red: 198/255, green: 92/255, blue: 82/255))
                    }
                    Spacer()
                    
                    Image("makeup_hero_group")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130, height: 95)
                }
                .padding(.horizontal, 16)
                NATabbarViewV1()
                NACarouselView()
                SeeAllButtonViewV1 {
                    print("See All tapped!")
                }
                .padding(16)
            }
            .background(Color(red: 253/255, green: 246/255, blue: 243/255))
        }
        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
        .listRowSeparator(.hidden)
    }
}

struct SeeAllButtonViewV1: View {
    var action: () -> Void = {}

    private let containerBackground = Color.white
    private let darkTextColor = Color(red: 30/255, green: 30/255, blue: 30/255)
    
    var body: some View {
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

struct SeeAllButtonViewV2: View {
    var action: () -> Void
    
    var body: some View {
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

// MARK: - Preview Setup Engine
#Preview {
    SeeAllButtonViewV2() {
        
    }
}
