//
//  NetworkStattre.swift
//  DigitalBank
//
//  Created by Muhammad on 17/09/25.
//

import Foundation

// MARK: - Network State
/// Network connectivity and API environment management
/// SRP: Handles only network-related concerns
struct NetworkState {
    // MARK: - Connectivity
    var isConnected: Bool = true
    var isOnline: Bool = true
    var connectionType: ConnectionType = .wifi

    // MARK: - API Configuration
    var apiEnvironment: APIEnvironment = .development
    var networkProvider: NetworkProviderType = .urlSession

    // MARK: - Loading States
    var isGlobalLoading: Bool = false
    var activeRequestCount: Int = 0

    // MARK: - Maintenance
    var isMaintenanceMode: Bool = false
}

// MARK: - Connection Type
/// Network connection types
enum ConnectionType: String, CaseIterable {
    case wifi = "wifi"
    case cellular = "cellular"
    case none = "none"

    var displayName: String {
        switch self {
        case .wifi: return "Wi-Fi"
        case .cellular: return "Mobil internet"
        case .none: return "Aloqa yo'q"
        }
    }

    var iconName: String {
        switch self {
        case .wifi: return "wifi"
        case .cellular: return "antenna.radiowaves.left.and.right"
        case .none: return "wifi.slash"
        }
    }
}

// MARK: - API Environment
/// API server environments for development workflow
enum APIEnvironment: String, CaseIterable {
    case development = "dev"
    case production = "prod"

    var displayName: String {
        switch self {
        case .development: return "Development"
        case .production: return "Production"
        }
    }

    var baseURL: String {
        switch self {
        case .development:
            return "https://my.fido.uz/dbgmkb/"
        case .production:
            return "https://ra.ubank.uz/api"
        }
    }

    var isSecure: Bool {
        return true  // Both use HTTPS
    }
}

// MARK: - Network Provider Type
/// Pluggable network layer providers
enum NetworkProviderType: String, CaseIterable {
    case urlSession = "URLSession"
    case alamofire = "Alamofire"
    case moya = "Moya"

    var displayName: String {
        return rawValue
    }

    var description: String {
        switch self {
        case .urlSession: return "Native iOS networking"
        case .alamofire: return "Popular Swift HTTP library"
        case .moya: return "Network abstraction layer"
        }
    }
}

// MARK: - Network State Extensions
extension NetworkState {
    /// Check if network is available for API calls
    var isNetworkAvailable: Bool {
        return isConnected && isOnline && !isMaintenanceMode
    }

    /// Check if using secure connection
    var isSecureConnection: Bool {
        return apiEnvironment.isSecure
    }

    /// Check if any network requests are active
    var hasActiveRequests: Bool {
        return activeRequestCount > 0
    }

    /// Get current API base URL
    var currentBaseURL: String {
        return apiEnvironment.baseURL
    }

    /// Check if using development environment
    var isDevelopmentMode: Bool {
        return apiEnvironment == .development
    }

    /// Check if using production environment
    var isProductionMode: Bool {
        return apiEnvironment == .production
    }

    /// Get connection quality indicator
    var connectionQuality: ConnectionQuality {
        switch connectionType {
        case .wifi:
            return isConnected ? .excellent : .poor
        case .cellular:
            return isConnected ? .good : .poor
        case .none:
            return .none
        }
    }
}

// MARK: - Connection Quality
enum ConnectionQuality: String, CaseIterable {
    case excellent = "excellent"
    case good = "good"
    case poor = "poor"
    case none = "none"

    var displayName: String {
        switch self {
        case .excellent: return "A'lo"
        case .good: return "Yaxshi"
        case .poor: return "Zaif"
        case .none: return "Yo'q"
        }
    }

    var color: String {
        switch self {
        case .excellent: return "#00CC00"
        case .good: return "#FFAA00"
        case .poor: return "#FF6600"
        case .none: return "#CC0000"
        }
    }
}

// MARK: - Network State Mutations
extension NetworkState {
    /// Update connectivity status
    mutating func updateConnectivity(isConnected: Bool, type: ConnectionType) {
        self.isConnected = isConnected
        self.connectionType = type
        self.isOnline = isConnected
    }

    /// Switch API environment
    mutating func switchEnvironment(_ environment: APIEnvironment) {
        apiEnvironment = environment
    }

    /// Switch network provider
    mutating func switchNetworkProvider(_ provider: NetworkProviderType) {
        networkProvider = provider
    }

    /// Start network request
    mutating func startRequest() {
        activeRequestCount += 1
        updateGlobalLoadingState()
    }

    /// End network request
    mutating func endRequest() {
        activeRequestCount = max(0, activeRequestCount - 1)
        updateGlobalLoadingState()
    }

    /// Update global loading state based on active requests
    private mutating func updateGlobalLoadingState() {
        isGlobalLoading = activeRequestCount > 0
    }

    /// Set maintenance mode
    mutating func setMaintenanceMode(_ isEnabled: Bool) {
        isMaintenanceMode = isEnabled
    }

    /// Reset network state to defaults
    mutating func resetToDefaults() {
        isConnected = true
        isOnline = true
        connectionType = .wifi
        apiEnvironment = .development
        networkProvider = .urlSession
        activeRequestCount = 0
        isGlobalLoading = false
        isMaintenanceMode = false
    }
}
