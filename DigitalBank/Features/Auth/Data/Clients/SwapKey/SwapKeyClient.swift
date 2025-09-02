//
//  SwapKeyClient.swift
//  DigitalBank
//
//  Created by Muhammad on 08/08/25.
//

import Foundation

protocol SwapKeyClient {
    func send(request: SwapKeyDTO.Request) async throws -> SwapKeyDTO.Response
}
