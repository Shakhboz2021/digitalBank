//
//  AppDevice.swift
//  DigitalBank
//
//  Created by Muhammad on 27/08/25.
//

import Foundation

struct AppDevice {
    let deviceType: String
    let deviceCode: String  // UUID in Keychain
    let deviceName: String
    let systemVersion: String
    init(
        deviceType: String,
        deviceCode: String,
        deviceName: String,
        systemVersion: String
    ) {
        self.deviceType = deviceType
        self.deviceCode = deviceCode
        self.deviceName = deviceName
        self.systemVersion = systemVersion
    }
}
