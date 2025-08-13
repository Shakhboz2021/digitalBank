//
//  AppConfig.swift
//  DigitalBank
//
//  Created by Muhammad on 11/08/25.
//

import Foundation

enum AppConfig {
    enum Environment {
        case production
        case ip
        case development
    }
    static let environment: Environment = .production
    static var baseURL: URL {
        switch environment {
        case .production:
            URL(string: "https://ra.ubank.uz/api")!
        case .ip:
            URL(string: "https://requestid.universalbank.uz/api/request/identify/")!
        case .development:
            URL(string: "https://my.fido.uz/dbgmkb/")!
        }
    }
}
