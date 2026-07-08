//
//  NAMessageView.swift
//  NammaAppUI
//
//  Created by apple on 02/04/26.
//
import SwiftUI

public struct NAMessageView: View {
    @State
    private var appTheme = AppThemeManager.shared
    
    //MARK: Stored Properties
    var title: String
    var subtitle: String
    var icon: String
    var onTapTryAgain: () -> Void
    
    //MARK: Initializer
    public init(title: String, subtitle: String, icon: String = "network_issue", onTapTryAgain: @escaping () -> Void) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.onTapTryAgain = onTapTryAgain
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            Image(icon, bundle: .module)
                .resizable()
                .scaledToFit()
                .padding(.top, 120)
            Text(title).font(.system(size: 16, weight: .semibold)).padding(.bottom, 6)
            Text(subtitle).font(.system(size: 12, weight: .regular)).padding(.bottom, 26).padding(.horizontal).foregroundStyle(Color.gray).multilineTextAlignment(.center)
            Button(action: {
                onTapTryAgain()
            }) {
                Text("Try again").font(.system(size: 12, weight: .medium)).foregroundStyle(appTheme.current.primary)
            }.buttonStyle(.plain)
            Spacer()
        }.background(appTheme.current.surface)
    }
}
