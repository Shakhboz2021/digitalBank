//
//  ThemeState.swift
//  DigitalBank
//
//  Created by Muhammad on 17/09/25.
//

import Foundation

// MARK: - Theme State
/// White Label theming and branding management
/// SRP: Handles only theming concerns
struct ThemeState {
    // MARK: - Brand Configuration
    var currentBrand: BrandType = .universal
    var currentLanguage: Language = .uzbek

    // MARK: - Theme Settings
    var isDarkMode: Bool = false
    var isSystemTheme: Bool = true
}

// MARK: - Brand Type
/// White Label brand configurations
enum BrandType: String, CaseIterable {
    case universal = "universal"
    case fido = "fido"

    var displayName: String {
        switch self {
        case .universal: return "Universal Bank"
        case .fido: return "FIDO Bank"
        }
    }

    var primaryColor: String {
        switch self {
        case .universal: return "#0066CC"
        case .fido: return "#FF6600"
        }
    }

    var secondaryColor: String {
        switch self {
        case .universal: return "#004499"
        case .fido: return "#CC4400"
        }
    }

    var logoName: String {
        switch self {
        case .universal: return "logo_universal"
        case .fido: return "logo_fido"
        }
    }

    var appName: String {
        return displayName
    }
}

// MARK: - Language
/// Multi-language support for Central Asia
enum Language: String, CaseIterable {
    case uzbek = "uz"
    case uzbekCyrillic = "uz-UZ"
    case russian = "ru"
    case english = "en"

    var displayName: String {
        switch self {
        case .uzbek: return "O'zbekcha"
        case .uzbekCyrillic: return "Ўзбекча"
        case .russian: return "Русский"
        case .english: return "English"
        }
    }

    var serverCode: String {
        switch self {
        case .uzbek: return "UZL"
        case .uzbekCyrillic: return "UZC"
        case .russian: return "RU"
        case .english: return "EN"
        }
    }

    var isRTL: Bool {  // Right-to-Left
        return false  // None of these languages are RTL
    }
}

// MARK: - Theme State Extensions
extension ThemeState {
    /// Get effective theme mode
    var effectiveThemeMode: ThemeMode {
        if isSystemTheme {
            return .system
        } else {
            return isDarkMode ? .dark : .light
        }
    }

    /// Get server language code for API calls
    var serverLanguageCode: String {
        return currentLanguage.serverCode
    }

    /// Check if current language is Cyrillic
    var isCyrillicLanguage: Bool {
        return currentLanguage == .uzbekCyrillic
    }

    /// Check if current language is local (Uzbek variants)
    var isLocalLanguage: Bool {
        return currentLanguage == .uzbek || currentLanguage == .uzbekCyrillic
    }

    /// Get brand primary color
    var brandPrimaryColor: String {
        return currentBrand.primaryColor
    }

    /// Get brand secondary color
    var brandSecondaryColor: String {
        return currentBrand.secondaryColor
    }

    /// Get brand logo name
    var brandLogoName: String {
        return currentBrand.logoName
    }

    /// Get localized app name
    var localizedAppName: String {
        return currentBrand.appName
    }
}

// MARK: - Theme Mode
enum ThemeMode: String, CaseIterable {
    case light = "light"
    case dark = "dark"
    case system = "system"

    var displayName: String {
        switch self {
        case .light: return "Yorug'"
        case .dark: return "Qorong'u"
        case .system: return "Sistema"
        }
    }
}

// MARK: - Theme State Mutations
extension ThemeState {
    /// Switch to specific brand
    mutating func switchToBrand(_ brand: BrandType) {
        currentBrand = brand
    }

    /// Switch to specific language
    mutating func switchToLanguage(_ language: Language) {
        currentLanguage = language
    }

    /// Toggle dark mode (only if not using system theme)
    mutating func toggleDarkMode() {
        if !isSystemTheme {
            isDarkMode.toggle()
        }
    }

    /// Enable system theme
    mutating func enableSystemTheme() {
        isSystemTheme = true
    }

    /// Set manual theme mode
    mutating func setManualTheme(isDark: Bool) {
        isSystemTheme = false
        isDarkMode = isDark
    }

    /// Reset to default theme settings
    mutating func resetToDefaults() {
        currentBrand = .universal
        currentLanguage = .uzbek
        isDarkMode = false
        isSystemTheme = true
    }
}
