//
//  SwapKeyEndpoint.swift
//  DigitalBank
//
//  Created by Muhammad on 11/08/25.
//

import Foundation

enum SwapKeyEndpoint {
    static var swapKey: URL {
        AppConfig.baseURL.appendingPathComponent("/v1/swapKey")
    }
}
