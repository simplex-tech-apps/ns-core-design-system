//
//  AppThemeManager.swift
//  NammaAppUI
//
//  Created by apple on 10/09/25.
//

import SwiftUI

enum AppThemeType {
    case light
    case dark
}

protocol Theme {
    var primary: Color { get }
    var onPrimary: Color { get }
    var secondary: Color { get }
    var onSecondary: Color { get }
    var tertiary: Color { get }
    var onTertiary: Color { get }
    var background: Color { get }
    var onBackground: Color { get }
    var surface: Color { get }
    var onSurface: Color { get }
    var error: Color { get }
    var onError: Color { get }
}

struct LightTheme: Theme {
    var primary: Color {
        Color(hex: 0x4DB848)
    }
    var onPrimary: Color {
        Color.white
    }
    var secondary: Color{
        Color(hex: 0x252731)
    }
    var onSecondary: Color{
        Color.white
    }
    var tertiary: Color{
        Color(hex: 0x624FF5)
    }
    var onTertiary: Color{
        Color.white
    }
    var background: Color{
        Color(hex: 0xF7F8F8)
    }
    var onBackground: Color{
        Color.white
    }
    var surface: Color{
        Color(hex: 0xF7F8F8)
    }
    var onSurface: Color{
        Color(hex: 0x252731)
    }
    var error: Color{
        Color.red
    }
    var onError: Color{
        Color.white
    }
}

struct DarkTheme: Theme {
    var primary: Color {
        Color.black
    }
    var onPrimary: Color {
        Color.white
    }
    var secondary: Color{
        Color.green
    }
    var onSecondary: Color{
        Color.white
    }
    var tertiary: Color{
        Color.blue
    }
    var onTertiary: Color{
        Color.white
    }
    var background: Color{
        Color.black
    }
    var onBackground: Color{
        Color.black
    }
    var surface: Color{
        Color.black
    }
    var onSurface: Color{
        Color.black
    }
    var error: Color{
        Color.black
    }
    var onError: Color{
        Color.black
    }
}

public actor AppThemeManager {
    static var current: Theme = LightTheme()
    static func apply(theme: AppThemeType) {
        switch theme {
        case .light: current = LightTheme()
        case .dark: current = DarkTheme()
        }
    }
}
