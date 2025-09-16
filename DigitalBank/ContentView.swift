//
//  ContentView.swift
//  DigitalBank
//
//  Created by Muhammad on 05/08/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var container: DIContainer
    @StateObject private var shared = SharedRouter()
    
    var body: some View {
        let bridge = AuthRoutingBridge(shared: shared)
        let vm = SignInViewModel(signIn: container.makeSignInUseCase(), router: bridge)
        
        return SignInView(vm: vm)
            .environmentObject(shared)
    }
}
