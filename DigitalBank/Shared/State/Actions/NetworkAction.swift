//
//  NetworkAction.swift
//  DigitalBank
//
//  Created by Muhammad on 18/09/25.
//

import Foundation

// MARK: - Network Actions
/// Network domain actions
/// SRP: Handles only network-related actions
enum NetworkAction {
    // MARK: - Connectivity
    case setConnectivity(isConnected: Bool, type: ConnectionType)
    case setOnlineStatus(Bool)

    // MARK: - Environment & Provider
    case setEnvironment(APIEnvironment)
    case setNetworkProvider(NetworkProviderType)

    // MARK: - Request Tracking
    case startRequest
    case endRequest

    // MARK: - Loading State
    case setLoading(Bool)

    // MARK: - Maintenance
    case setMaintenanceMode(Bool)

    // MARK: - Reset
    case resetToDefaults
}

// MARK: - Network Action Extensions
extension NetworkAction {
    /// Check if action affects API calls
    var affectsAPICall: Bool {
        switch self {
        case .setConnectivity, .setOnlineStatus, .setEnvironment,
            .setMaintenanceMode:
            return true
        case .setNetworkProvider:
            return true
        default:
            return false
        }
    }

    /// Check if action affects loading UI
    var affectsLoadingUI: Bool {
        switch self {
        case .startRequest, .endRequest, .setLoading:
            return true
        default:
            return false
        }
    }

    /// Check if action is connectivity related
    var isConnectivityAction: Bool {
        switch self {
        case .setConnectivity, .setOnlineStatus:
            return true
        default:
            return false
        }
    }

    /// Check if action affects development workflow
    var affectsDevelopmentWorkflow: Bool {
        switch self {
        case .setEnvironment, .setNetworkProvider:
            return true
        default:
            return false
        }
    }

    /// Check if action is critical for app functionality
    var isCritical: Bool {
        switch self {
        case .setMaintenanceMode(true), .setConnectivity(false, _):
            return true
        default:
            return false
        }
    }

    /// Get action category for analytics
    var category: NetworkActionCategory {
        switch self {
        case .setConnectivity, .setOnlineStatus:
            return .connectivity
        case .setEnvironment, .setNetworkProvider:
            return .configuration
        case .startRequest, .endRequest:
            return .request
        case .setLoading:
            return .loading
        case .setMaintenanceMode:
            return .maintenance
        case .resetToDefaults:
            return .reset
        }
    }

    /// Get action priority for processing
    var priority: NetworkActionPriority {
        switch self {
        case .setMaintenanceMode, .setConnectivity:
            return .high
        case .setEnvironment, .setNetworkProvider:
            return .medium
        case .startRequest, .endRequest, .setLoading, .setOnlineStatus:
            return .low
        case .resetToDefaults:
            return .medium
        }
    }
}

// MARK: - Network Action Category
enum NetworkActionCategory: String, CaseIterable {
    case connectivity = "connectivity"
    case configuration = "configuration"
    case request = "request"
    case loading = "loading"
    case maintenance = "maintenance"
    case reset = "reset"

    var displayName: String {
        switch self {
        case .connectivity: return "Ulanish"
        case .configuration: return "Konfiguratsiya"
        case .request: return "So'rov"
        case .loading: return "Yuklanish"
        case .maintenance: return "Texnik ishlar"
        case .reset: return "Qayta tiklash"
        }
    }
}

// MARK: - Network Action Priority
enum NetworkActionPriority: String, CaseIterable {
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

    var processingOrder: Int {
        switch self {
        case .low: return 1
        case .medium: return 2
        case .high: return 3
        }
    }
}
