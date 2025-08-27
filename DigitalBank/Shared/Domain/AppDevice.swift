//
//  AppDevice.swift
//  DigitalBank
//
//  Created by Muhammad on 27/08/25.
//

import Foundation

struct AppDevice {
    let deviceType: String
    let deviceCode: String
    let deviceName: String
    let deviceId: String  // UUID in Keychain
    init(
        deviceType: String,
        deviceCode: String,
        deviceName: String,
        deviceId: String
    ) {
        self.deviceType = deviceType
        self.deviceCode = deviceCode
        self.deviceName = deviceName
        self.deviceId = deviceId
    }
}
