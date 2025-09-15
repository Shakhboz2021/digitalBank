    //
    //  SignInViewModel.swift
    //  DigitalBank
    //
    //  Created by Muhammad on 11/09/25.
    //

import Foundation

@MainActor
protocol SignInRouting: AnyObject {
    func showSMS()
    func showError(_ message: String)
}

final class SignInViewModel: ObservableObject {
    
        //MARK: - Inputs
    @Published var phone: String = ""
    @Published var password: String = ""
    
        //MARK: - UI state
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
        //MARK: - Deps
    private let signIn: SignInUseCase
    weak var router: SignInRouting?
    
    init(signIn: SignInUseCase, router: SignInRouting) {
        self.signIn = signIn
        self.router = router
    }
    
    var canSubmit: Bool {
        !phone.isEmpty && !password.isEmpty && !isLoading
    }
    
    func submit() {
        guard canSubmit else { return }
        isLoading = true
        errorMessage = nil
        
        Task { @MainActor in
            defer { isLoading = false }
            do {
                let req = SignInModels.Request(
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
                    userInfo: .mock
                )
                
                _ = try await signIn.execute(request: req)
                router?.showSMS()
            } catch {
                let message = (error as NSError).localizedDescription
                errorMessage = message
                router?.showError(message)
            }
        }
    }
    
}
