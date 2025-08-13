//
//  ExternalConfig.swift
//  DigitalBank
//
//  Created by Muhammad on 13/08/25.
//

import Foundation

/// Tashqi (bank bazasidan mustaqil) servislar konfiguratsiyasi.
enum ExternalConfig {
    /// Bankdan mustaqil IP-info servisi (masalan: ip-api/ipify yoki bankning alohida serveri)
    static let getUserIPInfoURL = URL(
        string: "https://requestid.universalbank.uz/api/request/identify/"
    )!
}
