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
                    clientId: "-2",
                    phoneNumber: phone,
                    deviceType: DeviceInfo.current().deviceType,
                    deviceCode: DeviceInfo.current().deviceCode,
                    deviceName: DeviceInfo.current().deviceName,
                    version: "0",
                    password: password,
                    isPin: false,
                    appVersionCode: AppInfo.buildNumber,  // Bundle.main.infoDictionary?["CFBundleVersion"]
                    osVersion: DeviceInfo.current().systemVersion,
                    appVersion: AppInfo.releaseVersion,  // infoDictionary?["CFBundleShortVersionString"]
                    osSystemVersionApi: AppInfo.releaseVersion,
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
