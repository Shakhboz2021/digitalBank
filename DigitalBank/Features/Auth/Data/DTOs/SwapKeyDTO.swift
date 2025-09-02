//
//  SwapKeyDTO.swift
//  DigitalBank
//
//  Created by Muhammad on 11/08/25.
//

enum SwapKeyDTO {
    struct Request: Encodable {
        let public_key1: String
        let public_key2: String
        let encryptData: String
        let device_code: String
        let isPasEncrypt: Int
        let phone_number: String?

        init(domain: SwapKeyModels.Request) {
            self.public_key1 = domain.public_key1
            self.public_key2 = domain.public_key2
            self.encryptData = domain.encryptData
            self.device_code = domain.device_code
            self.isPasEncrypt = domain.isPasEncrypt
            self.phone_number = domain.phoneNumber
        }
    }
    struct Response: Codable, Equatable {
        let code: Int?
        let msg: String?
        let ecnryptData: String?
    }
}
