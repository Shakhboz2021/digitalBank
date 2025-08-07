//
//  SwapKeyRepositoryImpl.swift
//  DigitalBank
//
//  Created by Muhammad on 06/08/25.
//

import Foundation
final class SwapKeyRepositoryImpl: SwapKeyRepository {
    private let client: SwapKeyClient

    init(client: SwapKeyClient) {
        self.client = client
    }

    func swapKey(request: SwapKeyModels.Request) async throws -> SwapKeyModels.Response {
        try await client.send(request: request)
    }
}
