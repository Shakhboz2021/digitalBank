//
//  SharedRouter.swift
//  DigitalBank
//
//  Created by Muhammad on 15/09/25.
//

import Foundation

@MainActor
final class SharedRouter: ObservableObject {
        // Navigation flags
    @Published var showSMS = false
    
        // Payloads
    @Published var smsPayload: (phone: String, stringLine: String?)?
    
        // Errors (agar kerak bo‘lsa)
    @Published var alertMessage: String?
    
    func showSMS(phone: String, stringLine: String?) {
        smsPayload = (phone, stringLine)
        showSMS = true
    }
    
    func showError(_ message: String) {
        alertMessage = message
    }
    
    func popToRoot() {
        showSMS = false
        smsPayload = nil
        alertMessage = nil
    }
}
