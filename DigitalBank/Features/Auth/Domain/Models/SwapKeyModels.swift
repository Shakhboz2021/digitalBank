//
//  SwapKeyModels.swift
//  DigitalBank
//
//  Created by Muhammad on 08/08/25.
//

enum SwapKeyModels {
    struct Request: Equatable {
        let public_key1: String // g
        let public_key2: String // p
        let encryptData: String // big_A
        let device_code: String
        let isPasEncrypt: Int
        let phoneNumber: String?
    }
    
    struct Response: Equatable {
        var code: Int?
        var msg: String?
        var encryptData: String?
    }
}
