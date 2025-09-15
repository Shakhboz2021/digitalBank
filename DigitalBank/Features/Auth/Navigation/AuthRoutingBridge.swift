//
//  AuthRoutingBridge.swift
//  DigitalBank
//
//  Created by Muhammad on 15/09/25.
//

import Foundation

@MainActor
final class AuthRoutingBridge: SignInRouting {
    private weak var authRouter: AuthRouter?

    func attach(_ router: AuthRouter) { self.authRouter = router }

    func showSMS() { authRouter?.loginSuccess() }

    func showError(_ message: String) {}

}
