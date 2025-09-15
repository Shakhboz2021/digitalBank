//
//  SignInView.swift
//  DigitalBank
//
//  Created by Muhammad on 15/09/25.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var shared: SharedRouter
    @EnvironmentObject var authRouter: AuthRouter
    @StateObject private var vm: SignInViewModel
    @State private var showAlert: Bool = false

    init(vm: SignInViewModel? = nil) {
        if let vm {
            _vm = StateObject(wrappedValue: vm)
        } else {
            // DIContainer’dan olib kelamiz (quyida ContentView’da ko‘rsataman)
            _vm = StateObject(
                wrappedValue: SignInViewModel(
                    signIn: DIContainer().makeSignInUseCase(),
                    router: AuthRoutingBridge()
                )
            )
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                TextField("Telefon", text: $vm.phone)
                    .keyboardType(.phonePad)
                    .padding().background(Color(.secondarySystemBackground))
                    .cornerRadius(12)

                SecureField("Parol", text: $vm.password)
                    .padding().background(Color(.secondarySystemBackground))
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

                // iOS14: flag-based push
                NavigationLink(
                    destination: SMSView(),
                    isActive: $shared.showSMS
                ) {
                    EmptyView()
                }.hidden()
            }
            .padding()
            .overlay(
                Group {
                    if vm.isLoading {
                        ProgressView()
                    }
                }
            )
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Xato"),
                    message: Text(vm.errorMessage ?? "Noma’lum xato"),
                    dismissButton: .default(Text("OK"))
                )
            }
            .onChange(of: vm.errorMessage) { newValue in
                showAlert = newValue != nil
            }
            .navigationBarTitle("Kirish", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            // VM → Router ko‘prigini ulab qo‘yamiz
            (vm.router as? AuthRoutingBridge)?.attach(authRouter)
        }
    }
}

// Minimal SMS placeholder
struct SMSView: View {
    var body: some View {
        Text("SMS Screen")
    }
}
