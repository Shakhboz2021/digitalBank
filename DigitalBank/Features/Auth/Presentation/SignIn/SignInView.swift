//
//  SignInView.swift
//  DigitalBank
//
//  Created by Muhammad on 15/09/25.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var container: DIContainer
    @EnvironmentObject var shared: SharedRouter
    @StateObject private var vm: SignInViewModel

    init(vm: SignInViewModel? = nil) {
        if let vm {
            _vm = StateObject(wrappedValue: vm)
        } else {
            // default VM (runtime’da ContentView orqali to‘g‘ri container beriladi)
            let placeholder = SignInViewModel(
                signIn: DIContainer().makeSignInUseCase(),
                router: nil
            )
            _vm = StateObject(wrappedValue: placeholder)
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                TextField("Telefon", text: $vm.phone)
                    .keyboardType(.phonePad)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)

                SecureField("Parol", text: $vm.password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)

                Spacer()

                Button(action: vm.submit) {
                    Text("Kirish")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(vm.canSubmit ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(!vm.canSubmit)

                // iOS14: flag-based navigation
                NavigationLink(
                    destination: SMSView(),
                    isActive: $shared.showSMS
                ) {
                    EmptyView()
                }
                .hidden()
            }
            .padding()
            .overlay(Group { if vm.isLoading { ProgressView() } })
            // iOS14 .alert
            .alert(isPresented: .constant(vm.errorMessage != nil)) {
                Alert(
                    title: Text("Xato"),
                    message: Text(vm.errorMessage ?? "Noma'lum xato"),
                    dismissButton: .default(Text("OK")) {
                        vm.errorMessage = nil
                    }
                )
            }
            .navigationBarTitle("Kirish", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            // Real useCase bilan VM’ni qayta yaratamiz (haqiqiy DIContainer’dan)
            if vm.router == nil || !(vm.router is AuthRoutingBridge) {
                let bridge = AuthRoutingBridge(shared: shared)
                let realVM = SignInViewModel(
                    signIn: container.makeSignInUseCase(),
                    router: bridge
                )
                _vm.wrappedValue.phone = vm.phone
                _vm.wrappedValue.password = vm.password
                _vm.wrappedValue.errorMessage = vm.errorMessage
                // StateObject ichidagi instance’ni o‘zgartirish mumkin emas,
                // shuning uchun faqat initial init’da to‘g‘ri bering yoki
                // ContentView orqali injection qiling. Eng to‘g‘risi – ContentView’da.
            }
        }
    }
}

// Placeholder
struct SMSView: View {
    var body: some View { Text("SMS Screen") }
}
