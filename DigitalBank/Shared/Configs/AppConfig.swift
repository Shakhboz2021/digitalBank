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
    static let environment: Environment = .production
    static var baseURL: URL {
        switch environment {
        case .production:
            URL(string: "https:")!
        case .development:
            URL(string: "https:")!
        }
    }
}
