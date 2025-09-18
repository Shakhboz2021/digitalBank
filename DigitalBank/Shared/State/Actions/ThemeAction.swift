//
//  ThemeAction.swift
//  DigitalBank
//
//  Created by Muhammad on 18/09/25.
//

import Foundation

// MARK: - Theme Actions
/// Theme and branding domain actions
/// SRP: Handles only theming and White Label actions
enum ThemeAction {
    // MARK: - Brand Management
    case setBrand(BrandType)
    case setLanguage(Language)

    // MARK: - Theme Mode
    case setThemeMode(isDark: Bool)
    case enableSystemTheme
    case setManualTheme(isDark: Bool)

    // MARK: - Reset
    case resetToDefaults
}

// MARK: - Theme Action Extensions
extension ThemeAction {
    /// Check if action requires app restart
    var requiresAppRestart: Bool {
        switch self {
        case .setLanguage:
            return true
        case .setBrand:
            return false  // Can be applied immediately
        default:
            return false
        }
    }

    /// Check if action affects UI immediately
    var affectsUIImmediately: Bool {
        switch self {
        case .setBrand, .setThemeMode, .enableSystemTheme, .setManualTheme:
            return true
        case .setLanguage:
            return false  // Requires restart
        case .resetToDefaults:
            return true
        }
    }

    /// Check if action is White Label related
    var isWhiteLabelAction: Bool {
        switch self {
        case .setBrand:
            return true
        default:
            return false
        }
    }

    /// Check if action affects localization
    var affectsLocalization: Bool {
        switch self {
        case .setLanguage, .resetToDefaults:
            return true
        default:
            return false
        }
    }

    /// Get action category for analytics
    var category: ThemeActionCategory {
        switch self {
        case .setBrand:
            return .brand
        case .setLanguage:
            return .language
        case .setThemeMode, .enableSystemTheme, .setManualTheme:
            return .appearance
        case .resetToDefaults:
            return .reset
        }
    }

    /// Get action impact level
    var impactLevel: ThemeImpactLevel {
        switch self {
        case .setBrand, .setLanguage:
            return .high
        case .setThemeMode, .enableSystemTheme, .setManualTheme:
            return .medium
        case .resetToDefaults:
            return .high
        }
    }
}

// MARK: - Theme Action Category
enum ThemeActionCategory: String, CaseIterable {
    case brand = "brand"
    case language = "language"
    case appearance = "appearance"
    case reset = "reset"

    var displayName: String {
        switch self {
        case .brand: return "Brend"
        case .language: return "Til"
        case .appearance: return "Ko'rinish"
        case .reset: return "Qayta tiklash"
        }
    }
}

// MARK: - Theme Impact Level
enum ThemeImpactLevel: String, CaseIterable {
    case low = "low"
    case medium = "medium"
    case high = "high"

    var displayName: String {
        switch self {
        case .low: return "Past"
        case .medium: return "O'rtacha"
        case .high: return "Yuqori"
        }
    }

    var requiresConfirmation: Bool {
        switch self {
        case .low, .medium:
            return false
        case .high:
            return true
        }
    }
}
