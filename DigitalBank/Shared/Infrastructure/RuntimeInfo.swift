//
//  RuntimeInfo.swift
//  DigitalBank
//
//  Created by Muhammad on 27/08/25.
//

import UIKit

enum RuntimeInfo {
    static func currect() -> AppRuntime {
        let os = UIDevice.current.systemVersion
        let short = AppInfo.releaseVersion
        let build = AppInfo.buildNumber
        let api = "I"
        return .init(
            osVersion: os,
            appVersion: short,
            appVersionCode: build,
            osSystemVersionApi: api
        )
    }
}
