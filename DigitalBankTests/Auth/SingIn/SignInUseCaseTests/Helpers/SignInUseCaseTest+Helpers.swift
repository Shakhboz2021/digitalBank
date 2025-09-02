//
//  SignInUseCaseTest+Helpers.swift
//  DigitalBankTests
//
//  Created by Muhammad on 02/09/25.
//

import Foundation

@testable import DigitalBank

extension SignInUseCaseTests {
    func makeSignInRequest(
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

    func makeSignInResponse(
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

    func makeSUT() -> (sut: SignInUseCaseImpl, repository: SignInRepositorySpy)
    {
        let repo = SignInRepositorySpy()
        let sut = SignInUseCaseImpl(repository: repo)
        return (sut, repo)
    }
}
