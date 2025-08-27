//
//  Keychain.swift
//  DigitalBank
//
//  Created by Muhammad on 27/08/25.
//

import Foundation
import Security

enum KeychainKey: String {
    case domain = "DigitalBankData"
    case token = "KeychainAccess.token"
    case pin = "KeychainAccess.pin"
    case userId = "KeychainAccess.userId"
    case smsCode = "KeychainAccess.sms"
    case password = "KeychainAccess.password"
    case fcmToken = "KeychainAccess.fcmToken"
    case confirmPin = "KeychainAccess.confirmPin"
    case encryptedStringLine = "KeychainAccess.encryptedStringLine"
    case deviceID = "KeychainAccess.deviceID"  // never delete this key
    case phoneNumber = "KeychainAccess.phoneNumber"  // never delete this key
}

enum Keychain {
    private static let service = KeychainKey.domain.rawValue
    private static func baseQuery(for key: KeychainKey) -> [String: Any] {
        [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key.rawValue,
        ]
    }

    @discardableResult
    static func set(
        _ value: String,
        for key: KeychainKey,
        accessible: CFString = kSecAttrAccessibleWhenUnlockedThisDeviceOnly
    ) -> Bool {
        var query = baseQuery(for: key)
        let data = Data(value.utf8)

        SecItemDelete(query as CFDictionary)

        query[kSecValueData as String] = data
        query[kSecAttrAccessible as String] = accessible

        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }

    static func get(key: KeychainKey) -> String {
        var query = baseQuery(for: key)
        query[kSecReturnData as String] = true
        query[kSecMatchLimit as String] = kSecMatchLimitOne

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess, let data = item as? Data,
            let str = String(data: data, encoding: .utf8)
        else {
            return ""
        }
        return str
    }

    @discardableResult
    static func remove(key: KeychainKey) -> Bool {
        let status = SecItemDelete(baseQuery(for: key) as CFDictionary)
        return status == errSecSuccess || status == errSecItemNotFound
    }

    /// Barchasini o‘chirish (lekin deviceID/phoneNumber NI SAQLAB QO‘YAMIZ)
    static func removeAllPreservingDevice() {
        // 1) Eski qiymatlarni saqlab qolamiz
        let preservedDeviceID = get(key: .deviceID)
        let preservedPhone = get(key: .phoneNumber)

        // 2) Hamma generic-password’larni o‘chiramiz
        let q: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
        ]
        SecItemDelete(q as CFDictionary)

        // 3) Zarur kalitlarni qayta tiklaymiz
        if !preservedDeviceID.isEmpty { set(preservedDeviceID, for: .deviceID) }
        if !preservedPhone.isEmpty { set(preservedPhone, for: .phoneNumber) }
    }

    static func hasPin() -> Bool { !get(key: .pin).isEmpty }
}

// MARK: - DeviceID helper (doimiy identifikator)
enum DeviceCodeProvider {
    static func deviceCode() -> String? {
        Keychain.get(key: .deviceID)
    }
}
