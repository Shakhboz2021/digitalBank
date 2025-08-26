//
//  SignInDTO.swift
//  DigitalBank
//
//  Created by Muhammad on 26/08/25.
//

import Foundation

enum SignInDTO {
    struct Request: Encodable, Equatable {
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
        let userInfo: UserIPInfoDTO
        enum CodingKeys: String, CodingKey {
            case clientId = "client_id"
            case phoneNumber = "phone_number"
            case deviceType = "device_type"
            case deviceCode = "device_code"
            case deviceName = "device_name"
            case version
            case password
            case isPin = "is_pin"
            case appVersionCode = "app_version_code"
            case osVersion = "os_version"
            case appVersion = "app_version"
            case osSystemVersionApi = "os_system_version_api"
            case userInfo
        }
    }

    struct Response: Decodable, Equatable {
        let code: Int?
        let message: String?
        let stringLine: String?
        let deviceMyIdState: String?
        enum CodingKeys: String, CodingKey {
            case code
            case message = "msg"
            case stringLine = "string_line"
            case deviceMyIdState = "device_myid_state"
        }
    }
}
