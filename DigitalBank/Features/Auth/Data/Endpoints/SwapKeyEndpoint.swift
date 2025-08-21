//
//  SwapKeyEndpoint.swift
//  DigitalBank
//
//  Created by Muhammad on 11/08/25.
//

import Foundation

enum SwapKeyEndpoint: Endpoint {
    var url: URL {
        AppConfig.
    }

    var method: HTTPMethod

    static var swapKey: URL {
        AppConfig.baseURL.appendingPathComponent("/v1/swapKey")
    }
}
