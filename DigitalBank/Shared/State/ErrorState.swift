//
//  ErrorState.swift
//  DigitalBank
//
//  Created by Muhammad on 17/09/25.
//

import Foundation

// MARK: - Error State
/// Error handling and user feedback
/// SRP: Handles only error management concerns
struct ErrorState {
    // MARK: - Current Error
    var currentError: AppError? = nil
    var isShowingError: Bool = false
}

// MARK: - App Error
/// Application-specific error types
/// Banking-grade error categorization
enum AppError: Error, Equatable, Identifiable {
    // MARK: - Network Errors
    case networkError(String)
    case serverError(code: Int, message: String)
    case noConnection

    // MARK: - Authentication Errors
    case invalidCredentials
    case sessionExpired
    case accountBlocked
    case maxLoginAttemptsExceeded

    // MARK: - Validation Errors
    case invalidPhoneNumber
    case invalidPassword
    case invalidSMSCode
    case invalidPIN

    // MARK: - Business Errors
    case insufficientBalance
    case dailyLimitExceeded
    case transactionFailed

    // MARK: - System Errors
    case unknownError(String)

    var id: String {
        switch self {
        case .networkError(let msg): return "network_\(msg.hashValue)"
        case .serverError(let code, _): return "server_\(code)"
        case .noConnection: return "no_connection"
        case .invalidCredentials: return "invalid_credentials"
        case .sessionExpired: return "session_expired"
        case .accountBlocked: return "account_blocked"
        case .maxLoginAttemptsExceeded: return "max_login_attempts"
        case .invalidPhoneNumber: return "invalid_phone"
        case .invalidPassword: return "invalid_password"
        case .invalidSMSCode: return "invalid_sms"
        case .invalidPIN: return "invalid_pin"
        case .insufficientBalance: return "insufficient_balance"
        case .dailyLimitExceeded: return "daily_limit"
        case .transactionFailed: return "transaction_failed"
        case .unknownError(let msg): return "unknown_\(msg.hashValue)"
        }
    }
}

// MARK: - Error Extensions
extension AppError {
    /// User-friendly error messages
    var localizedDescription: String {
        switch self {
        // Network Errors
        case .networkError(let message):
            return "Tarmoq xatosi: \(message)"
        case .serverError(_, let message):
            return message.isEmpty ? "Server xatosi" : message
        case .noConnection:
            return "Internet aloqasi yo'q"

        // Auth Errors
        case .invalidCredentials:
            return "Telefon raqam yoki parol noto'g'ri"
        case .sessionExpired:
            return "Sessiya muddati tugadi. Qayta kiring"
        case .accountBlocked:
            return "Hisob bloklangan. Qo'llab-quvvatlash bilan bog'laning"
        case .maxLoginAttemptsExceeded:
            return "Juda ko'p urinish. Keyinroq urinib ko'ring"

        // Validation Errors
        case .invalidPhoneNumber:
            return "Telefon raqam formati noto'g'ri"
        case .invalidPassword:
            return "Parol kamida 4 ta belgidan iborat bo'lishi kerak"
        case .invalidSMSCode:
            return "SMS kod noto'g'ri"
        case .invalidPIN:
            return "PIN kod noto'g'ri"

        // Business Errors
        case .insufficientBalance:
            return "Hisobda mablag' yetarli emas"
        case .dailyLimitExceeded:
            return "Kunlik limit oshib ketdi"
        case .transactionFailed:
            return "Tranzaksiya amalga oshmadi"

        // System
        case .unknownError(let message):
            return "Noma'lum xato: \(message)"
        }
    }

    /// Check if error is recoverable
    var isRecoverable: Bool {
        switch self {
        case .networkError, .serverError, .noConnection:
            return true
        case .invalidCredentials, .invalidPhoneNumber, .invalidPassword,
            .invalidSMSCode, .invalidPIN:
            return true
        case .sessionExpired:
            return true
        case .accountBlocked, .maxLoginAttemptsExceeded:
            return false
        case .insufficientBalance, .dailyLimitExceeded, .transactionFailed:
            return true
        case .unknownError:
            return true
        }
    }

    /// Check if error requires immediate attention
    var isCritical: Bool {
        switch self {
        case .accountBlocked, .maxLoginAttemptsExceeded, .sessionExpired:
            return true
        default:
            return false
        }
    }
}

// MARK: - Error State Extensions
extension ErrorState {
    /// Check if there are any errors
    var hasErrors: Bool {
        return currentError != nil
    }

    /// Set current error and show it
    mutating func showError(_ error: AppError) {
        currentError = error
        isShowingError = true
    }

    /// Clear current error
    mutating func clearCurrentError() {
        currentError = nil
        isShowingError = false
    }

    /// Set error with priority (critical errors override non-critical)
    mutating func setError(_ error: AppError) {
        if let current = currentError {
            // Replace with critical error if current is not critical
            if error.isCritical && !current.isCritical {
                showError(error)
            }
        } else {
            showError(error)
        }
    }
}
