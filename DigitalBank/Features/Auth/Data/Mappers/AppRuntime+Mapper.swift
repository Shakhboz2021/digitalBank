//
//  AppRuntime+Mapper.swift
//  DigitalBank
//
//  Created by Muhammad on 27/08/25.
//

import Foundation

extension AppRuntime {
    func toDTO() -> AppRuntimeDTO {
        .init(
            osVersion: osVersion,
            appVersion: appVersion,
            appVersionCode: appVersionCode,
            osSystemVersionApi: osSystemVersionApi
        )
    }
}
