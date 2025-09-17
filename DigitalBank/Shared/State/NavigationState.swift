//
//  NavigationState.swift
//  DigitalBank
//
//  Created by Muhammad on 17/09/25.
//

import Foundation

// MARK: - Navigation State
/// App navigation and flow management
/// SRP: Handles only navigation concerns
struct NavigationState {
    // MARK: - Current Flow State
    var currentFlow: AppFlow = .auth
    var authFlow: AuthFlow = .signIn

    // MARK: - Modal Presentations
    var presentedSheet: SheetType? = nil
    var presentedAlert: AlertType? = nil

    // MARK: - Navigation Loading States
    var isNavigationLoading: Bool = false
}

// MARK: - Navigation Types
enum AppFlow: String, Equatable, CaseIterable {
    case auth = "auth"
    case main = "main"
}

enum AuthFlow: String, Equatable, CaseIterable {
    case signIn = "sign_in"
    case sms = "sms_verification"
    case pinSetup = "pin_setup"
    case pinEntry = "pin_entry"
}

enum SheetType: Equatable {
    case settings
    case help
    case logout
    case sms(phone: String)
}

enum AlertType: Equatable {
    case error(String)
    case confirmation(String)
    case info(String)
}

// MARK: - Navigation State Extensions
extension NavigationState {
    /// Check if any modal is presented
    var hasModalPresented: Bool {
        presentedSheet != nil || presentedAlert != nil
    }

    /// Check if user is in authentication flow
    var isInAuthFlow: Bool {
        currentFlow == .auth
    }

    /// Check if user is in main app flow
    var isInMainFlow: Bool {
        currentFlow == .main
    }
}
