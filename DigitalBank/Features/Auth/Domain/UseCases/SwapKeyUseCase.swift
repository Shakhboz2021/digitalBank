//
//  SwapKeyUseX.swift
//  DigitalBank
//
//  Created by Muhammad on 08/08/25.
//

import Foundation

protocol SwapKeyUseCase {
    func execute(request: SwapKeyModels.Request) async throws -> SwapKeyModels.Response
}

final class SwapKeyUseCaseImpl: SwapKeyUseCase {
    private let client: SwapKeyClient
    
    init(client: SwapKeyClient) {
        self.client = client
    }
    
    func execute(request: SwapKeyModels.Request) async throws -> SwapKeyModels.Response {
        try await client.send(request: request)
    }

}
