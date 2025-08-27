//
//  AppRuntime.swift
//  DigitalBank
//
//  Created by Muhammad on 27/08/25.
//

import Foundation

struct AppRuntime {
    let osVersion: String
    let appVersion: String
    let appVersionCode: String
    let osSystemVersionApi: String
    init(
        osVersion: String,
        appVersion: String,
        appVersionCode: String,
        osSystemVersionApi: String
    ) {
        self.osVersion = osVersion
        self.appVersion = appVersion
        self.appVersionCode = appVersionCode
        self.osSystemVersionApi = osSystemVersionApi
    }
}
