//
//  Store.swift
//  DigitalBank
//
//  Created by Muhammad on 18/09/25.
//

import Combine
import Foundation

// MARK: - Redux Store
/// Centralized state management store
/// Redux Pattern: Single source of truth with unidirectional data flow
/// Thread Safe: @MainActor ensures UI updates on main thread
@MainActor
final class Store: ObservableObject {

    // MARK: - Published State
    @Published private(set) var state = AppState()

    // MARK: - Dependencies
    private let signInUseCase: SignInUseCase
    private let getUserIPInfoUseCase: GetUserIPInfoUseCase
    private let swapKeyUseCase: SwapKeyUseCase

    // MARK: - Internal State
    private var cancellables = Set<AnyCancellable>()
    private let actionQueue = DispatchQueue(
        label: "store.actions",
        qos: .userInitiated
    )

    // MARK: - Initialization
    init(
        signInUseCase: SignInUseCase,
        getUserIPInfoUseCase: GetUserIPInfoUseCase,
        swapKeyUseCase: SwapKeyUseCase
    ) {
        self.signInUseCase = signInUseCase
        self.getUserIPInfoUseCase = getUserIPInfoUseCase
        self.swapKeyUseCase = swapKeyUseCase

        setupMiddleware()
    }

    // MARK: - Action Dispatch
    /// Dispatch action to modify state
    /// Redux Pattern: Actions are the only way to change state
    func dispatch(_ action: AppAction) {
        #if DEBUG
            print("🔄 Action: \(action.description)")
        #endif

        // Handle side effects first (async operations)
        handleSideEffects(action)

        // Update state synchronously
        reduce(action: action)

        #if DEBUG
            print("✅ State updated")
        #endif
    }

    // MARK: - Reducer
    /// Pure function that updates state based on action
    /// Redux Pattern: Reducers are pure functions (no side effects)
    private func reduce(action: AppAction) {
        switch action {
        case .auth(let authAction):
            reduceAuthState(action: authAction)
        case .navigation(let navAction):
            reduceNavigationState(action: navAction)
        case .error(let errorAction):
            reduceErrorState(action: errorAction)
        case .theme(let themeAction):
            reduceThemeState(action: themeAction)
        case .network(let networkAction):
            reduceNetworkState(action: networkAction)
        }
    }

    // MARK: - Auth Reducer
    private func reduceAuthState(action: AuthAction) {
        switch action {
        case .startLogin:
            // Loading handled by ViewModel, session logic here
            break

        case .loginSuccess(let token):
            state.authState.setSessionToken(token)
            state.authState.markSessionValid()

        case .loginFailure:
            state.authState.incrementLoginAttempts()

        case .incrementLoginAttempts:
            state.authState.incrementLoginAttempts()

        case .sessionExpired:
            state.authState.markSessionExpired()

        case .sessionRestored:
            state.authState.markSessionValid()

        case .logout:
            state.authState.clearSession()

        case .setSessionToken(let token):
            state.authState.setSessionToken(token)

        case .clearSession:
            state.authState.clearSession()
        }
    }

    // MARK: - Navigation Reducer
    private func reduceNavigationState(action: NavigationAction) {
        switch action {
        case .setFlow(let flow):
            state.navigationState.currentFlow = flow

        case .setAuthFlow(let authFlow):
            state.navigationState.authFlow = authFlow

        case .showSheet(let sheet):
            state.navigationState.presentedSheet = sheet

        case .showAlert(let alert):
            state.navigationState.presentedAlert = alert

        case .dismissSheet:
            state.navigationState.presentedSheet = nil

        case .dismissAlert:
            state.navigationState.presentedAlert = nil

        case .dismissAllModals:
            state.navigationState.presentedSheet = nil
            state.navigationState.presentedAlert = nil

        case .setNavigationLoading(let isLoading):
            state.navigationState.isNavigationLoading = isLoading
        }
    }

    // MARK: - Error Reducer
    private func reduceErrorState(action: ErrorAction) {
        switch action {
        case .showError(let error):
            state.errorState.showError(error)

        case .clearError:
            state.errorState.clearCurrentError()

        case .setErrorDisplayState(let isShowing):
            state.errorState.isShowingError = isShowing
        }
    }

    // MARK: - Theme Reducer
    private func reduceThemeState(action: ThemeAction) {
        switch action {
        case .setBrand(let brand):
            state.themeState.switchToBrand(brand)

        case .setLanguage(let language):
            state.themeState.switchToLanguage(language)

        case .setThemeMode(let isDark):
            state.themeState.setManualTheme(isDark: isDark)

        case .enableSystemTheme:
            state.themeState.enableSystemTheme()

        case .setManualTheme(let isDark):
            state.themeState.setManualTheme(isDark: isDark)

        case .resetToDefaults:
            state.themeState.resetToDefaults()
        }
    }

    // MARK: - Network Reducer
    private func reduceNetworkState(action: NetworkAction) {
        switch action {
        case .setConnectivity(let isConnected, let type):
            state.networkState.updateConnectivity(
                isConnected: isConnected,
                type: type
            )

        case .setOnlineStatus(let isOnline):
            state.networkState.isOnline = isOnline

        case .setEnvironment(let environment):
            state.networkState.switchEnvironment(environment)

        case .setNetworkProvider(let provider):
            state.networkState.switchNetworkProvider(provider)

        case .startRequest:
            state.networkState.startRequest()

        case .endRequest:
            state.networkState.endRequest()

        case .setLoading(let isLoading):
            state.networkState.isLoading = isLoading

        case .setMaintenanceMode(let isEnabled):
            state.networkState.setMaintenanceMode(isEnabled)

        case .resetToDefaults:
            state.networkState.resetToDefaults()
        }
    }

    // MARK: - Side Effects (Middleware)
    /// Handle async operations and side effects
    /// Redux Pattern: Side effects are handled separately from reducers
    private func handleSideEffects(_ action: AppAction) {
        switch action {
        case .auth(.startLogin(let phone, let password)):
            handleLoginSideEffect(phone: phone, password: password)

        case .auth(.sessionExpired):
            handleSessionExpiredSideEffect()

        case .network(.setMaintenanceMode(true)):
            handleMaintenanceModeSideEffect()

        default:
            break
        }
    }

    // MARK: - Auth Side Effects
    private func handleLoginSideEffect(phone: String, password: String) {
        Task {
            do {
                // Get user IP info first
                let userIPInfo = try await getUserIPInfoUseCase.execute()

                // Create sign-in request
                let request = SignInModels.Request(
                    phoneNumber: phone,
                    password: password,
                    deviceType: DeviceInfo.deviceType,
                    deviceCode: DeviceInfo.deviceCode,
                    deviceName: DeviceInfo.deviceName,
                    osVersion: DeviceInfo.systemVersion,
                    appVersionCode: AppInfo.buildNumber,
                    appVersion: AppInfo.releaseVersion,
                    osSystemVersionApi: AppInfo.releaseVersion,
                    version: "0",
                    isPin: "0",
                    clientId: "-2",
                    userInfo: userIPInfo
                )

                // Perform sign-in
                let response = try await signInUseCase.execute(request: request)

                // Handle success
                await MainActor.run {
                    self.dispatch(
                        .auth(.loginSuccess(token: response.stringLine ?? ""))
                    )
                    self.dispatch(.navigation(.setAuthFlow(.sms)))
                    self.dispatch(.navigation(.showSheet(.sms(phone: phone))))
                }

            } catch {
                // Handle failure
                await MainActor.run {
                    self.dispatch(.auth(.loginFailure))

                    if let networkError = error as? NetworkError {
                        switch networkError {
                        case .non2xx(let status) where status == 401:
                            self.dispatch(
                                .error(.showError(.invalidCredentials))
                            )
                        default:
                            self.dispatch(
                                .error(
                                    .showError(
                                        .networkError(
                                            error.localizedDescription
                                        )
                                    )
                                )
                            )
                        }
                    } else {
                        self.dispatch(
                            .error(
                                .showError(
                                    .unknownError(error.localizedDescription)
                                )
                            )
                        )
                    }
                }
            }
        }
    }

    private func handleSessionExpiredSideEffect() {
        // Clear sensitive data
        dispatch(.auth(.clearSession))
        dispatch(.navigation(.setFlow(.auth)))
        dispatch(.navigation(.dismissAllModals))
        dispatch(.error(.showError(.sessionExpired)))
    }

    private func handleMaintenanceModeSideEffect() {
        // Handle maintenance mode
        dispatch(.navigation(.dismissAllModals))
        dispatch(
            .error(
                .showError(
                    .serverError(
                        code: 503,
                        message: "Tizim texnik ishlar olib borilmoqda"
                    )
                )
            )
        )
    }

    // MARK: - Middleware Setup
    private func setupMiddleware() {
        // Auto-clear errors after timeout
        $state
            .map(\.errorState.currentError)
            .compactMap { $0 }
            .sink { [weak self] error in
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self?.dispatch(.error(.clearError))
                }
            }
            .store(in: &cancellables)

        // Handle authentication state changes
        $state
            .map(\.authState.isSessionExpired)
            .removeDuplicates()
            .filter { $0 == true }
            .sink { [weak self] _ in
                self?.dispatch(.auth(.sessionExpired))
            }
            .store(in: &cancellables)
    }
}

// MARK: - Store Extensions
extension Store {
    /// Check if user is authenticated
    var isAuthenticated: Bool {
        state.authState.hasValidSession
    }

    /// Get current brand theme
    var currentBrand: BrandType {
        state.themeState.currentBrand
    }

    /// Check if app is loading
    var isLoading: Bool {
        state.isGlobalLoading
    }

    /// Get active error
    var activeError: AppError? {
        state.activeError
    }
}

// MARK: - Development Helpers
#if DEBUG
    extension Store {
        /// Reset store to initial state (for testing)
        func resetToInitialState() {
            state = AppState()
        }

        /// Get state for debugging
        func debugState() -> AppState {
            return state
        }
    }
#endif
