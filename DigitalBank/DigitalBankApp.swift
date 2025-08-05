//
//  DigitalBankApp.swift
//  DigitalBank
//
//  Created by Muhammad on 05/08/25.
//

import SwiftUI

@main
struct DigitalBankApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
