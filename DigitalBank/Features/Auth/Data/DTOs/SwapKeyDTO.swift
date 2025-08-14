//
//  SwapKeyDTO.swift
//  DigitalBank
//
//  Created by Muhammad on 11/08/25.
//

enum SwapKeyDTO {
    struct Response: Codable {
        let code: Int?
        let msg: String?
        let ecnryptData: String?

        func toDomain() -> SwapKeyModels.Response {
            .init(code: code, msg: msg, ecnryptData: ecnryptData)
        }
    }
}
