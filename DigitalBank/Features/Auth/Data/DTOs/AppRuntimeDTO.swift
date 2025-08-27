//
//  AppRuntimeDTO.swift
//  DigitalBank
//
//  Created by Muhammad on 27/08/25.
//

import Foundation

struct AppRuntimeDTO: Encodable, Equatable {
    let osVersion: String
    let appVersion: String
    let appVersionCode: String
    let osSystemVersionApi: String
    enum CodingKeys: String, CodingKey {
        case osVersion = "os_version"
        case appVersion = "app_version"
        case appVersionCode = "app_version_code"
        case osSystemVersionApi = "os_system_version_api"
    }
}
