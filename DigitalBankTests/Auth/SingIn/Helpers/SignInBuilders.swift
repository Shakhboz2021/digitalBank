//
//  SignInTests+Builders.swift
//  DigitalBankTests
//
//  Created by Muhammad on 03/09/25.
//

import Foundation

@testable import DigitalBank

enum SignInBuilders {
    static func makeSignInRequest(
        clientId: String = "test-client",
        phoneNumber: String = "998901234567",
        deviceType: String = "I",
        deviceCode: String = "device-code",
        deviceName: String = "iPhone",
        version: String = "1.0",
        password: String = "secret",
        isPin: Bool = false,
        appVersionCode: String = "100",
        osVersion: String = "18.0",
        appVersion: String = "1.0.0",
        osSystemVersionApi: String = "iOS18",
        userInfo: UserIPInfo = .mock
    ) -> SignInModels.Request {
        .init(
            clientId: clientId,
            phoneNumber: phoneNumber,
            deviceType: deviceType,
            deviceCode: deviceCode,
            deviceName: deviceName,
            version: version,
            password: password,
            isPin: isPin,
            appVersionCode: appVersionCode,
            osVersion: osVersion,
            appVersion: appVersion,
            osSystemVersionApi: osSystemVersionApi,
            userInfo: userInfo
        )
    }

    static func makeSignInResponse(
        code: Int? = 200,
        message: String? = "OK",
        stringLine: String? = "test-line",
        deviceMyIdState: String? = "A"
    ) -> SignInModels.Response {
        .init(
            code: code,
            message: message,
            stringLine: stringLine,
            deviceMyIdState: deviceMyIdState
        )
    }

}

extension SignInModels.Request {
    static var mock: Self {
        SignInBuilders.makeSignInRequest()
    }
}

extension SignInModels.Response {
    static var mock: Self {
        SignInBuilders.makeSignInResponse()
    }
}

extension SignInDTO.Request {
    static var mock: Self {
        .init(
            clientId: "id",
            phoneNumber: "998901234567",
            deviceType: "I",
            deviceCode: "device-code",
            deviceName: "iPhone",
            version: "1.0",
            password: "secret",
            isPin: false,
            appVersionCode: "100",
            osVersion: "18.0",
            appVersion: "1.0.0",
            osSystemVersionApi: "iOS18",
            userInfo: .mock
        )
    }
}

extension SignInDTO.Response {
    static var mock: Self {
        .init(
            code: 200,
            message: "OK",
            stringLine: "test-line",
            deviceMyIdState: "A"
        )
    }
}
