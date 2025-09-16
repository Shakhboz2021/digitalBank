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
        case development
    }
    static let environment: Environment = .development
    static var baseURL: URL {
        let urlString: String
        switch environment {
        case .production:
            urlString = "https://ra.ubank.uz/api"
        case .development:
            urlString = "https://my.fido.uz/dbgmkb/"
        }
        guard let url = URL(string: urlString) else {
            preconditionFailure("Invalid Base URL: \(urlString)")
        }
        return url
    }
}
