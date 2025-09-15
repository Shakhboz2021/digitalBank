//
//  ContentView.swift
//  DigitalBank
//
//  Created by Muhammad on 05/08/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var shared = SharedRouter()
    @StateObject private var authRouter: AuthRouter
    private let container = DIContainer()

    init() {
        let shared = SharedRouter()
        _authRouter = StateObject(wrappedValue: AuthRouter(shared: shared))
    }

    var body: some View {
        // DI container’dan haqiqiy usecase
        let vm = SignInViewModel(
            signIn: container.makeSignInUseCase(),
            router: AuthRoutingBridge()
        )

        SignInView(vm: vm)
            .environmentObject(shared)
            .environmentObject(authRouter)
    }
}
