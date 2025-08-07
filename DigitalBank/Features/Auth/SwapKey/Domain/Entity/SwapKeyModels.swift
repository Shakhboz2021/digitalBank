//
//  SwapKeyModels.swift
//  DigitalBank
//
//  Created by Muhammad on 06/08/25.
//

import Foundation

public enum SwapKeyModels {

    public struct Request: Codable {
        public let public_key1: String // g
        public let public_key2: String // p
        public let encryptData: String // big_A
        public let device_code: String
        public let isPasEncrypt: Int
        public let phoneNumber: String?

        public init(publicKeyOne: String, publicKeyTwo: String, encryptData: String, deviceCode: String, isPasEncrypt: Int, phoneNumber: String? = nil) {
            self.public_key1 = publicKeyOne
            self.public_key2 = publicKeyTwo
            self.encryptData = encryptData
            self.device_code = deviceCode
            self.isPasEncrypt = isPasEncrypt
            self.phoneNumber = phoneNumber
        }
    }

    public struct Response: Codable {
        public var code: Int?
        public var msg: String?
        public var encryptData: String?

        public init(code: Int? = nil, msg: String? = nil, encryptData: String? = nil) {
            self.code = code
            self.msg = msg
            self.encryptData = encryptData
        }
    }
}
