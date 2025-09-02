//
//  SwapKeyMappers.swift
//  DigitalBank
//
//  Created by Muhammad on 02/09/25.
//

import Foundation

extension SwapKeyModels.Request {
    func toDTO() -> SwapKeyDTO.Request {
        .init(domain: self)
    }
}

extension SwapKeyDTO.Response {
    func toDomain() -> SwapKeyModels.Response {
        .init(
            code: code,
            msg: msg,
            encryptData: ecnryptData
        )
    }
}
