//
//  SwapKeyRepositorySpy.swift
//  DigitalBank
//
//  Created by Muhammad on 06/08/25.
//

import Foundation


class SwapKeyRepositorySpy: SwapKeyRepository {
    var receiveRequest: SwapKeyModels.Request?
    var subbedResponse: SwapKeyModels.Response?
    
    
    func swapKey(request: SwapKeyModels.Request) async throws -> SwapKeyModels.Response {
        receiveRequest = request
        guard let response = subbedResponse else {
            throw URLError(.badServerResponse)
        }
        return response
    }
    
}
