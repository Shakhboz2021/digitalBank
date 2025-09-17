//
//  AuthEndpoint.swift
//  DigitalBank
//
//  Created by Muhammad on 21/08/25.
//

import Foundation

enum AuthEndpoint: Endpoint {
    case swapKey
    case swapKeyPin
    case getUserIPInfo
    case signIn

    var url: URL {
        switch self {
        case .swapKey:
            AppConfig.baseURL.appendingPathComponent("v1/swapKey")
        case .swapKeyPin:
            AppConfig.baseURL.appendingPathComponent("v1/swapKeyPin")
        case .getUserIPInfo:
            ExternalConfig.getUserIPInfoURL
        case .signIn:
            AppConfig.baseURL.appendingPathComponent("USER_SIGN_IN_NEW")
        }
    }

    var method: HTTPMethod {
        switch self {
        case .swapKey, .swapKeyPin, .signIn:
            return .post
        case .getUserIPInfo:
            return .get
        }
    }

}
