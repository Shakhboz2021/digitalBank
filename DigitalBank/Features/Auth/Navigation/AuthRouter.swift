//
//  AuthRouter.swift
//  DigitalBank
//
//  Created by Muhammad on 15/09/25.
//

import SwiftUI

final class AuthRouter: ObservableObject {
    @ObservedObject var shared: SharedRouter
    init(shared: SharedRouter) {
        self.shared = shared
    }
    func loginSuccess() { shared.showSMS = true }
    func showPin() { shared.showPIN = true }
    func showSuccess() { shared.showSuccess = true }
    
    func popToSignIn() {
        shared.showSMS = false
        shared.showPIN = false
    }
}
