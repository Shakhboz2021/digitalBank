//
//  AuthRoutingBridge.swift
//  DigitalBank
//
//  Created by Muhammad on 15/09/25.
//

import Foundation

/// ViewModel -> Router ko'prigi (UI-ga bog'lanmaydi)
@MainActor
final class AuthRoutingBridge: SignInRouting {
    private weak var shared: SharedRouter?

    init(shared: SharedRouter? = nil) {
        self.shared = shared
    }

    func attach(_ shared: SharedRouter) {
        self.shared = shared
    }

    func showSMS(phone: String, stringLine: String?) {
        shared?.showSMS(phone: phone, stringLine: stringLine)
    }

    func showError(_ message: String) {
        shared?.showError(message)
    }
}
