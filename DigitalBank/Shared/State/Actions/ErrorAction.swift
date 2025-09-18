//
//  ErrorAction.swift
//  DigitalBank
//
//  Created by Muhammad on 18/09/25.
//

import Foundation

// MARK: - Error Actions
/// Error handling domain actions
/// SRP: Handles only error management actions
enum ErrorAction {
    // MARK: - Error Display
    case showError(AppError)
    case clearError

    // MARK: - Error State Management
    case setErrorDisplayState(Bool)
}

// MARK: - Error Action Extensions
extension ErrorAction {
    /// Get error severity level
    var severity: ErrorSeverity {
        switch self {
        case .showError(let error):
            return error.isCritical ? .critical : .normal
        case .clearError, .setErrorDisplayState:
            return .low
        }
    }

    /// Check if action shows error to user
    var showsErrorToUser: Bool {
        switch self {
        case .showError:
            return true
        case .clearError, .setErrorDisplayState:
            return false
        }
    }

    /// Check if action clears error state
    var clearsError: Bool {
        switch self {
        case .clearError:
            return true
        case .showError, .setErrorDisplayState:
            return false
        }
    }

    /// Get error category for analytics
    var category: ErrorActionCategory {
        switch self {
        case .showError:
            return .display
        case .clearError:
            return .clear
        case .setErrorDisplayState:
            return .state
        }
    }

    /// Check if action requires user interaction
    var requiresUserInteraction: Bool {
        switch self {
        case .showError:
            return true
        case .clearError, .setErrorDisplayState:
            return false
        }
    }
}

// MARK: - Error Severity
enum ErrorSeverity: String, CaseIterable {
    case low = "low"
    case normal = "normal"
    case critical = "critical"

    var displayName: String {
        switch self {
        case .low: return "Past"
        case .normal: return "O'rtacha"
        case .critical: return "Jiddiy"
        }
    }

    var priority: Int {
        switch self {
        case .low: return 1
        case .normal: return 2
        case .critical: return 3
        }
    }
}

// MARK: - Error Action Category
enum ErrorActionCategory: String, CaseIterable {
    case display = "display"
    case clear = "clear"
    case state = "state"

    var displayName: String {
        switch self {
        case .display: return "Ko'rsatish"
        case .clear: return "Tozalash"
        case .state: return "Holat"
        }
    }
}
