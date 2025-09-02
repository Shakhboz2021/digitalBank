//
//  SwapKeyRepositotyImpl.swift
//  DigitalBank
//
//  Created by Muhammad on 11/08/25.
//

import Foundation

class SwapKeyRepositoryImpl: SwapKeyRepository {
    private let client: SwapKeyClient
    
    init(client: SwapKeyClient) {
        self.client = client
    }

    func swapKey(request: SwapKeyModels.Request) async throws -> SwapKeyModels.Response {
        let dtoRequest = request.toDTO()
        let dtoResponse = try await client.send(request: dtoRequest)
        return dtoResponse.toDomain()
    }

}
