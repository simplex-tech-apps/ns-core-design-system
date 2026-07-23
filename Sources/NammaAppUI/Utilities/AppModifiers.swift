//
//  AppModifiers.swift
//  NammaAppUI
//
//  Created by apple on 10/09/25.
//

import SwiftUI

struct NAShadowEffectV1: ViewModifier {
    func body(content: Content) -> some View {
        content.shadow(color: Color.black.opacity(0.02), radius: 8, x: 0, y: 0)
    }
}

struct NAShadowEffectV2: ViewModifier {
    func body(content: Content) -> some View {
        content.shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 0)
    }
}

struct NAShadowEffectV3: ViewModifier {
    var shadowOpacity: Double
    
    func body(content: Content) -> some View {
        content.shadow(color: Color.black.opacity(shadowOpacity), radius: 16, x: 0, y: 0)
    }
}


struct NAButtonModifiers: ViewModifier {
    var staticButtonType: StaticButtonTypes
    
    func body(content: Content) -> some View {
        switch staticButtonType {
        case .plain(_, let foregroundColor, let backgroundColor, _):
            content
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 12))
                .tint(backgroundColor)
                .foregroundStyle(foregroundColor)
        case .link(_):
            content.buttonStyle(.borderless)
        default:
            content
        }
    }
}

struct NACardViewEffectV1: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            content
        }.frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(12)
            .addShadowEffectV1()
    }
}

struct NACardViewEffectV2: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            content
        }.frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(20)
            .addShadowEffectV2()
    }
}

extension View {
    public func addShadowEffectV1() -> some View {
        self.modifier(NAShadowEffectV1())
    }
    
    public func addCardViewEffectV1() -> some View {
        self.modifier(NACardViewEffectV1())
    }
    
    public func addShadowEffectV2() -> some View {
        self.modifier(NAShadowEffectV2())
    }
    
    public func addCardViewEffectV2() -> some View {
        self.modifier(NACardViewEffectV2())
    }
    
    public func addShadowEffectV3(shadowOpacity: Double) -> some View {
        self.modifier(NAShadowEffectV3(shadowOpacity: shadowOpacity))
    }
    
    public func addStaticButtonModifier(staticButtonType: StaticButtonTypes) -> some View {
        self.modifier(NAButtonModifiers(staticButtonType: staticButtonType))
    }
}


