//
//  AuthAssembly.swift
//  DigitalBank
//
//  Created by Muhammad on 11/08/25.
//

import Foundation

protocol AuthAssembling {
    func makeSwapKeyUseCase() -> SwapKeyUseCase
}

class AuthAssembly: AuthAssembling {
    func makeSwapKeyUseCase() -> SwapKeyUseCase { // Dependency Inversion
        let client = SwapKeyClientImpl(url: SwapKeyEndpoint.swapKey)
        let repository = SwapKeyRepositoryImpl(client: client)
        return SwapKeyUseCaseImpl(repository: repository)
    }
}
