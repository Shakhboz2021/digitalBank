//
//  SharedRouter.swift
//  DigitalBank
//
//  Created by Muhammad on 15/09/25.
//

import Foundation

final class SharedRouter: ObservableObject {
    @Published var showSMS = false
    @Published var showPIN = false
    @Published var showSuccess = false

    func popToRoot() {
        showPIN = false
        showSMS = false
        showSuccess = false
    }
}
