//
//  NAVerifiedBadge.swift
//  NammaAppUI
//
//  Created by apple on 25/01/26.
//

import SwiftUI

public struct NAUserVerificationBadge: View {
    
    @State
    private var appTheme = AppThemeManager.shared
    
    public init() {}
    
    public var body: some View {
        HStack(spacing: 0) {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 25)
                    .fill(appTheme.current.onSecondary)
                    .frame(height: 30)
                    .addCardViewEffectV2()
                HStack(spacing: 0) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .fill(appTheme.current.secondary)
                            .padding(4)
                            .frame(width: 30, height: 30)
                        Image(systemName: "person.fill").resizable().frame(width: 12, height: 12).foregroundColor(appTheme.current.onSecondary)
                    }
                    Image(systemName: "star.fill").resizable().frame(width: 12, height: 12).padding(.horizontal, 2).foregroundColor(appTheme.current.tertiary)
                    Text("34").font(.system(size: 12, weight: .medium)).padding(.leading, 4).foregroundStyle(appTheme.current.secondary)
                    Text("(344)").font(.system(size: 12, weight: .medium)).padding(.trailing, 10).foregroundStyle(Color.gray)
                }
            }.fixedSize(horizontal: true, vertical: true).zIndex(1)
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(appTheme.current.primary)
                    .frame(height: 30)
                    .addCardViewEffectV2()
                Text("VERIFIED").font(.system(size: 10, weight: .medium)).padding(.horizontal, 10).padding(.leading, 50).foregroundStyle(appTheme.current.onPrimary)
            }.fixedSize(horizontal: true, vertical: true).offset(x: -50)
        }
    }
}

#Preview {
    NAUserVerificationBadge()
}


