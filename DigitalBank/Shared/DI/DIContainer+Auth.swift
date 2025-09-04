//
//  DIContainer+Auth.swift
//  DigitalBank
//
//  Created by Muhammad on 13/08/25.
//

import Foundation

extension DIContainer {
    func makeSwapKeyUseCase() -> SwapKeyUseCase {
        auth.makeSwapKeyUseCase()
    }

    func makeGetUserIPInfoUseCase() -> GetUserIPInfoUseCase {
        auth.makeGetUserIPInfoUseCase()
    }

    func makeSignInUseCase() -> SignInUseCase {
        auth.makeSignInUseCase()
    }
}
