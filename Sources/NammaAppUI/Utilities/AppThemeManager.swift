//
//  AppThemeManager.swift
//  NammaAppUI
//
//  Created by apple on 10/09/25.
//

import SwiftUI

public enum AppThemeType {
    case light
    case dark
}

public protocol Theme {
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

public struct LightTheme: Theme {

    public init() {}

    public let primary = Color(hex: 0x4DB848)
    public let onPrimary = Color.white

    public let secondary = Color(hex: 0x252731)
    public let onSecondary = Color.white

    public let tertiary = Color(hex: 0x624FF5)
    public let onTertiary = Color.white

    public let background = Color(hex: 0xF7F8F8)
    public let onBackground = Color.black

    public let surface = Color(hex: 0xFFFFFF)
    public let onSurface = Color(hex: 0x252731)

    public let error = Color.red
    public let onError = Color.white
}

public struct DarkTheme: Theme {

    public init() {}

    public let primary = Color(hex: 0x4DB848)
    public let onPrimary = Color.white

    public let secondary = Color(hex: 0xE5E5E5)
    public let onSecondary = Color.black

    public let tertiary = Color(hex: 0x624FF5)
    public let onTertiary = Color.white

    public let background = Color.black
    public let onBackground = Color.white

    public let surface = Color(hex: 0x1C1C1E)
    public let onSurface = Color.white

    public let error = Color.red
    public let onError = Color.white
}

@MainActor
@Observable
public final class AppThemeManager {
    public static let shared = AppThemeManager()
    public var current: Theme = LightTheme()

    private init() {}

    public func apply(_ theme: Theme) {
        current = theme
    }
}
