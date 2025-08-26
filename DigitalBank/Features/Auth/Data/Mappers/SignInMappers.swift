//
//  SignInMappers.swift
//  DigitalBank
//
//  Created by Muhammad on 26/08/25.
//

import Foundation

// MARK: - Request: Domain -> DTO
extension SignInModels.Request {
    func toDTO() -> SignInDTO.Request {
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
            userInfo: userInfo.toDTO()
        )
    }
}

extension SignInDTO.Response {
    func toDomain() -> SignInModels.Response {
        .init(
            code: code,
            message: message,
            stringLine: stringLine,
            deviceMyIdState: deviceMyIdState
        )
    }
}
