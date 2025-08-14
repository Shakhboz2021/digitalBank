//
//  SwapKeyDTO+Helpers.swift
//  DigitalBankTests
//
//  Created by Muhammad on 14/08/25.
//

import Foundation

@testable import DigitalBank

extension SwapKeyDTO.Response {
    static var mock: Self {
        .init(
            code: 200,
            msg: "Success",
            ecnryptData: "123"
        )
    }
}
