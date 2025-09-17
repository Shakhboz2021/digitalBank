//
//  AppState.swift
//  DigitalBank
//
//  Created by Muhammad on 17/09/25.
//

import Foundation

// MARK: - App State (Single Source of Truth)
/// Redux pattern: Centralized application state composition
/// SRP: Composes domain states, delegates responsibility to each domain
/// CQS: Read-only state, modified only through actions
struct AppState {
    var authState: AuthState = AuthState()
    var navigationState: NavigationState = NavigationState()
    var errorState: ErrorState = ErrorState()
    var themeState: ThemeState = ThemeState()
    var networkState: NetworkState = NetworkState()
}

// MARK: - State Extensions
/// Computed properties for cross-domain state queries
extension AppState {
    /// Check if user needs authentication
    var needsAuthentication: Bool {
        !authState.isAuthenticated || authState.isSessionExpired
    }

    /// Check if app is in loading state
    var isGlobalLoading: Bool {
        authState.isLoading || navigationState.isNavigationLoading
            || networkState.isGlobalLoading
    }

    /// Get current active error
    var activeError: AppError? {
        errorState.currentError
    }

    /// Check if any modal is presented
    var hasModalPresented: Bool {
        navigationState.hasModalPresented
    }

    /// Get current brand configuration
    var currentBrand: BrandType {
        themeState.currentBrand
    }

    /// Check if network is available
    var isNetworkAvailable: Bool {
        networkState.isConnected && networkState.isOnline
    }
}
