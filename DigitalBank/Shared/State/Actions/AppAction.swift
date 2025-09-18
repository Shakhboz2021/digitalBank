//
//  AppAction.swift
//  DigitalBank
//
//  Created by Muhammad on 18/09/25.
//

import Foundation

// MARK: - App Actions
/// Root action type for Redux pattern
/// SRP: Coordinates all domain actions
/// Type Safety: Enum-based actions prevent invalid mutations
enum AppAction {
    case auth(AuthAction)
    case navigation(NavigationAction)
    case error(ErrorAction)
    case theme(ThemeAction)
    case network(NetworkAction)
}

// MARK: - Action Extensions
extension AppAction {
    /// Get action description for debugging
    var description: String {
        switch self {
        case .auth(let authAction):
            return "Auth: \(authAction)"
        case .navigation(let navAction):
            return "Navigation: \(navAction)"
        case .error(let errorAction):
            return "Error: \(errorAction)"
        case .theme(let themeAction):
            return "Theme: \(themeAction)"
        case .network(let networkAction):
            return "Network: \(networkAction)"
        }
    }

    /// Check if action is critical (for logging priority)
    var isCritical: Bool {
        switch self {
        case .auth(let authAction):
            return authAction.isCritical
        case .error(.showError(let error)):
            return error.isCritical
        case .network(.setMaintenanceMode(true)):
            return true
        default:
            return false
        }
    }

    /// Get action domain for categorization
    var domain: ActionDomain {
        switch self {
        case .auth: return .authentication
        case .navigation: return .navigation
        case .error: return .error
        case .theme: return .theme
        case .network: return .network
        }
    }
}

// MARK: - Action Domain
/// Action categorization for analytics and debugging
enum ActionDomain: String, CaseIterable {
    case authentication = "auth"
    case navigation = "navigation"
    case error = "error"
    case theme = "theme"
    case network = "network"

    var displayName: String {
        switch self {
        case .authentication: return "Autentifikatsiya"
        case .navigation: return "Navigatsiya"
        case .error: return "Xato"
        case .theme: return "Tema"
        case .network: return "Tarmoq"
        }
    }
}
