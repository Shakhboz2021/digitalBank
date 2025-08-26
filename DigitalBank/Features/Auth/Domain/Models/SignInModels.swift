//
//  SignInModels.swift
//  DigitalBank
//
//  Created by Muhammad on 26/08/25.
//

import Foundation

enum SignInModels {
    struct Request: Equatable {
        let clientId: String
        let phoneNumber: String
        let deviceType: String
        let deviceCode: String
        let deviceName: String
        let version: String
        let password: String
        let isPin: Bool
        let appVersionCode: String
        let osVersion: String
        let appVersion: String
        let osSystemVersionApi: String
        let userInfo: UserIPInfo
        init(
            clientId: String,
            phoneNumber: String,
            deviceType: String,
            deviceCode: String,
            deviceName: String,
            version: String,
            password: String,
            isPin: Bool,
            appVersionCode: String,
            osVersion: String,
            appVersion: String,
            osSystemVersionApi: String,
            userInfo: UserIPInfo
        ) {
            self.clientId = clientId
            self.phoneNumber = phoneNumber
            self.deviceType = deviceType
            self.deviceCode = deviceCode
            self.deviceName = deviceName
            self.version = version
            self.password = password
            self.isPin = isPin
            self.appVersionCode = appVersionCode
            self.osVersion = osVersion
            self.appVersion = appVersion
            self.osSystemVersionApi = osSystemVersionApi
            self.userInfo = userInfo
        }
    }
    struct Response: Equatable {
        public let code: Int?
        public let message: String?
        public let stringLine: String?
        public let deviceMyIdState: String?
    }
}
