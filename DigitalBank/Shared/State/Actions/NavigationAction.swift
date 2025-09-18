//
//  NavigationAction.swift
//  DigitalBank
//
//  Created by Muhammad on 18/09/25.
//

import Foundation

// MARK: - Navigation Actions
/// Navigation domain actions
/// SRP: Handles only navigation-related actions
enum NavigationAction {
    // MARK: - Flow Management
    case setFlow(AppFlow)
    case setAuthFlow(AuthFlow)

    // MARK: - Modal Management
    case showSheet(SheetType)
    case showAlert(AlertType)
    case dismissSheet
    case dismissAlert
    case dismissAllModals

    // MARK: - Loading States
    case setNavigationLoading(Bool)
}

// MARK: - Navigation Action Extensions
extension NavigationAction {
    /// Check if action shows modal
    var showsModal: Bool {
        switch self {
        case .showSheet, .showAlert:
            return true
        default:
            return false
        }
    }

    /// Check if action dismisses modal
    var dismissesModal: Bool {
        switch self {
        case .dismissSheet, .dismissAlert, .dismissAllModals:
            return true
        default:
            return false
        }
    }

    /// Check if action changes app flow
    var changesFlow: Bool {
        switch self {
        case .setFlow, .setAuthFlow:
            return true
        default:
            return false
        }
    }

    /// Check if action affects loading UI
    var affectsLoadingUI: Bool {
        switch self {
        case .setNavigationLoading:
            return true
        default:
            return false
        }
    }

    /// Get action category for analytics
    var category: NavigationActionCategory {
        switch self {
        case .setFlow, .setAuthFlow:
            return .flow
        case .showSheet, .showAlert, .dismissSheet, .dismissAlert,
            .dismissAllModals:
            return .modal
        case .setNavigationLoading:
            return .loading
        }
    }
}

// MARK: - Navigation Action Category
enum NavigationActionCategory: String, CaseIterable {
    case flow = "flow"
    case modal = "modal"
    case loading = "loading"

    var displayName: String {
        switch self {
        case .flow: return "Oqim"
        case .modal: return "Modal"
        case .loading: return "Yuklanish"
        }
    }
}
