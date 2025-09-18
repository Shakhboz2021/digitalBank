//
//  AuthAction.swift
//  DigitalBank
//
//  Created by Muhammad on 18/09/25.
//

import Foundation

// MARK: - Auth Actions
/// Authentication domain actions
/// SRP: Handles only authentication-related actions
enum AuthAction {
    // MARK: - Login Flow
    case startLogin(phone: String, password: String)
    case loginSuccess(token: String)
    case loginFailure
    case incrementLoginAttempts

    // MARK: - Session Management
    case sessionExpired
    case sessionRestored
    case logout

    // MARK: - Token Management
    case setSessionToken(String)
    case clearSession
}

// MARK: - Auth Action Extensions
extension AuthAction {
    /// Check if action affects authentication state
    var affectsAuthState: Bool {
        switch self {
        case .startLogin, .loginSuccess, .loginFailure, .sessionExpired,
            .logout:
            return true
        case .incrementLoginAttempts, .sessionRestored, .setSessionToken,
            .clearSession:
            return true
        }
    }

    /// Check if action is critical for security
    var isCritical: Bool {
        switch self {
        case .sessionExpired, .loginFailure, .logout:
            return true
        case .incrementLoginAttempts:
            return true
        default:
            return false
        }
    }

    /// Check if action requires network call
    var requiresNetwork: Bool {
        switch self {
        case .startLogin:
            return true
        default:
            return false
        }
    }

    /// Get action category for analytics
    var category: AuthActionCategory {
        switch self {
        case .startLogin, .loginSuccess, .loginFailure, .incrementLoginAttempts:
            return .login
        case .sessionExpired, .sessionRestored:
            return .session
        case .logout, .clearSession:
            return .logout
        case .setSessionToken:
            return .token
        }
    }
}

// MARK: - Auth Action Category
enum AuthActionCategory: String, CaseIterable {
    case login = "login"
    case session = "session"
    case logout = "logout"
    case token = "token"

    var displayName: String {
        switch self {
        case .login: return "Kirish"
        case .session: return "Sessiya"
        case .logout: return "Chiqish"
        case .token: return "Token"
        }
    }
}
