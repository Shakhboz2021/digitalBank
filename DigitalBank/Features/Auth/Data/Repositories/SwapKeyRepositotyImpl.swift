//
//  SwapKeyRepositotyImpl.swift
//  DigitalBank
//
//  Created by Muhammad on 11/08/25.
//

import Foundation

class SwapKeyRepositotyImpl: SwapKeyRepository {
    private let client: SwapKeyClient
    
    init(client: SwapKeyClient) {
        self.client = client
    }

    func swapKey(request: SwapKeyModels.Request) async throws -> SwapKeyModels.Response {
        try await client.send(request: request)
    }

}
