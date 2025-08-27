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
        let short =
            Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            ?? "0"
        let build =
            Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "0"
        let api = os.split(separator: ".").first.map(String.init) ?? os
        return .init(
            osVersion: os,
            appVersion: short,
            appVersionCode: build,
            osSystemVersionApi: api
        )
    }
}
