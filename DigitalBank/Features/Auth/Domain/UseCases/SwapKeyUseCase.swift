//
//  SwapKeyUseX.swift
//  DigitalBank
//
//  Created by Muhammad on 08/08/25.
//

import Foundation

protocol SwapKeyUseCase {
    func execute(request: SwapKeyModels.Request) async throws
        -> SwapKeyModels.Response
}

final class SwapKeyUseCaseImpl: SwapKeyUseCase {
    private let repository: SwapKeyRepository

    init(repository: SwapKeyRepository) {
        self.repository = repository
    }

    func execute(request: SwapKeyModels.Request) async throws
        -> SwapKeyModels.Response
    {
        try await repository.swapKey(request: request)
    }

}
