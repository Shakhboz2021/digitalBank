//
//  SignInViewModel.swift
//  DigitalBank
//
//  Created by Muhammad on 11/09/25.
//

import Foundation

@MainActor
protocol SignInRouting: AnyObject {
    func showSMS(phone: String, stringLine: String?)
    func showError(_ message: String)
}

@MainActor
final class SignInViewModel: ObservableObject {
    @Published var phone: String = ""
    @Published var password: String = ""
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?
    
    private let signIn: SignInUseCase
    weak var router: SignInRouting?
    
    init(signIn: SignInUseCase, router: SignInRouting?) {
        self.signIn = signIn
        self.router  = router
    }
    
    var canSubmit: Bool { !phone.isEmpty && !password.isEmpty && !isLoading }
    
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
                let res = try await signIn.execute(request: req)
                router?.showSMS(phone: phone, stringLine: res.stringLine)
            } catch {
                let msg = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
                self.errorMessage = msg
                router?.showError(msg)
            }
        }
    }
}
