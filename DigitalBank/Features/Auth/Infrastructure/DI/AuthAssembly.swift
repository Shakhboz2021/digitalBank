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
    private let network: NetworkSession
    init(network: NetworkSession = DefaultNetworkSession()) {
        self.network = network
    }
    func makeSwapKeyUseCase() -> SwapKeyUseCase {  // Dependency Inversion
        let client = SwapKeyClientImpl(
            network: network,
            endpoint: AuthEndpoint.swapKey
        )
        let repository = SwapKeyRepositoryImpl(client: client)
        return SwapKeyUseCaseImpl(repository: repository)
    }
    func makeGetUserIPInfoUseCase() -> any GetUserIPInfoUseCase {
        let client = GetUserIPInfoClientImpl(
            network: network,
            endpoint: AuthEndpoint.getUserIPInfo
        )
        let repository = GetUserIPInfoRepositoryImpl(client: client)
        return GetUserIPInfoUseCaseImpl(repository: repository)
    }
}
