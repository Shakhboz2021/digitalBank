//
//  SwapKeyModels+Helpers.swift
//  DigitalBankTests
//
//  Created by Muhammad on 08/08/25.
//

import Foundation

@testable import DigitalBank

extension SwapKeyModels.Request {
    static var mock: Self {
        .init(
            public_key1: "5", // g: oddiy generator
            public_key2: "23", // p: kichik tub son
            encryptData: "8", // big_A: A = (g^a) mod p
            device_code: "iPhoone13",
            isPasEncrypt: 0,
            phoneNumber: "998995711661"
        )
    }
}

extension SwapKeyModels.Response {
    static var mock: Self {
        .init(code: 0, msg: "Success", ecnryptData: "123")
    }
}
