//
//  SignInViewModel.swift
//  DigitalBank
//
//  Created by Muhammad on 11/09/25.
//

import Foundation

@MainActor

final class SignInViewModel: ObservableObject {
    @Published var phone: String = ""
    @Published var password: String = ""
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var navigateToSMS: (phone: String, line: String?)? = nil

    private let signIn: SignInUseCase

    init(signIn: SignInUseCase) {
        self.signIn = signIn
    }

    var canSubmit: Bool {
        !phone.isEmpty && !password.isEmpty && !isLoading
    }

    func submit() {
        guard canSubmit else { return }
        isLoading = true
        errorMessage = nil

        Task {
            do {
                let req = SignInModels.Request(
                    phoneNumber: phone,
                    password: password,
                    deviceType: DeviceInfo.deviceType,
                    deviceCode: DeviceInfo.deviceCode,
                    deviceName: DeviceInfo.deviceName,
                    osVersion: DeviceInfo.systemVersion,
                    appVersionCode: AppInfo.buildNumber,  // Bundle.main.infoDictionary?["CFBundleVersion"]
                    appVersion: AppInfo.releaseVersion,  // Bundle.main.infoDictionary?["CFBundleShortVersionString"]
                    osSystemVersionApi: AppInfo.releaseVersion,
                    version: "0",
                    isPin: "0",
                    clientId: "-2",
                    userInfo: .mock
                )
                let result = try await signIn.execute(request: req)
                isLoading = false
                navigateToSMS = (phone, result.stringLine)
            } catch {
                isLoading = false
                errorMessage = error.localizedDescription
            }
        }
    }

}
