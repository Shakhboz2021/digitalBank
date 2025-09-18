//
//  AuthState.swift
//  DigitalBank
//
//  Created by Muhammad on 17/09/25.
//

// MARK: - Auth State
/// Authentication state management
/// SRP: Handles only authentication concerns
struct AuthState {
    // MARK: - Basic Authentication
    var isAuthenticated: Bool = false
    var loginAttempts: Int = 0
    var maxLoginAttempts: Int = 3

    // MARK: - Session Management (401-based)
    var sessionToken: String?
    private(set) var isSessionExpired: Bool = false  // ✅ Private setter
}

// MARK: - Extensions
extension AuthState {
    /// Check if user can attempt login
    var canAttemptLogin: Bool {
        return loginAttempts < maxLoginAttempts
    }

    /// Check if user has valid session
    var hasValidSession: Bool {
        return isAuthenticated && !isSessionExpired && sessionToken != nil
    }

    /// Handle 401 response - mark session as expired
    mutating func markSessionExpired() {
        isSessionExpired = true
        isAuthenticated = false
        // Keep sessionToken for potential refresh
    }

    /// Handle successful login - reset session state
    mutating func markSessionValid() {
        isSessionExpired = false
        isAuthenticated = true
        loginAttempts = 0
    }

    /// Increment login attempts
    mutating func incrementLoginAttempts() {
        loginAttempts += 1
    }

    /// Reset login attempts after successful login
    mutating func resetLoginAttempts() {
        loginAttempts = 0
    }

    /// Set session token
    mutating func setSessionToken(_ token: String) {
        sessionToken = token
    }

    /// Clear session data
    mutating func clearSession() {
        sessionToken = nil
        isAuthenticated = false
        isSessionExpired = false
    }
}
