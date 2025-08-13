//
//  AuthAssembly.swift
//  DigitalBank
//
//  Created by Muhammad on 11/08/25.
//

import Foundation

protocol AuthAssembling {
    func makeSwapKeyUseCase() -> SwapKeyUseCase
    func makeGetUserIPInfoUseCase() -> GetUserIPInfoUseCase
}

class AuthAssembly: AuthAssembling {

    func makeSwapKeyUseCase() -> SwapKeyUseCase { // Dependency Inversion
        let client = SwapKeyClientImpl(url: SwapKeyEndpoint.swapKey)
        let repository = SwapKeyRepositoryImpl(client: client)
        return SwapKeyUseCaseImpl(repository: repository)
    }
    func makeGetUserIPInfoUseCase() -> any GetUserIPInfoUseCase {
        let client = GetUserIPInfoClientImpl(url: GetUserIPInfoEndpoint.url)
        let repository = GetUserIPInfoRepositoryImpl(client: client)
        return GetUserIPInfoUseCaseImpl(repository: repository)
    }
}
