//
//  DigitalBankApp.swift
//  DigitalBank
//
//  Created by Muhammad on 05/08/25.
//

import SwiftUI

@main
struct DigitalBankApp: App {
    @StateObject private var container = DIContainer()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(container)
        }
    }
}
