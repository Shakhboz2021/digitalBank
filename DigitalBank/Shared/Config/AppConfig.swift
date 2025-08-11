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
        case staging
        case development
    }
    static let environment: Environment = .production
    static var baseURL: URL {
        switch environment {
        case .production:
            URL(string: "https://ra.ubank.uz/api")!
        case .staging:
            URL(string: "https://api.staging.digitalbank.id")!
        case .development:
            URL(string: "https://my.fido.uz/dbgmkb/")!
        }
    }
}
