//
//  AuthState.swift
//  DigitalBank
//
//  Created by Muhammad on 17/09/25.
//

import Foundation

// MARK: - Auth State
/// Authentication state management
/// SRP: Handles only authentication concerns
struct AuthState {
    // MARK: - Basic Authentication
    var isAuthenticated: Bool = false
    var loginAttempts: Int = 0
    var maxLoginAttempts: Int = 3

    // MARK: - Session Management
    var sessionToken: String?
}

// MARK: - Extensions
extension AuthState {
    /// Check if user can attempt login
    var canAttemptLogin: Bool {
        loginAttempts < maxLoginAttempts
    }
}
