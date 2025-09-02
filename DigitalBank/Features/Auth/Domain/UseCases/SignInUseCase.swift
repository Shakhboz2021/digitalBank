//
//  SignInUseCase.swift
//  DigitalBank
//
//  Created by Muhammad on 02/09/25.
//

import Foundation

protocol SignInUseCase {
    func execute(request: SignInModels.Request) async throws
        -> SignInModels.Response
}

final class SignInUseCaseImpl: SignInUseCase {
    private let repository: SignInRepository

    init(repository: SignInRepository) {
        self.repository = repository
    }
    func execute(request: SignInModels.Request) async throws
        -> SignInModels.Response
    {
        try await repository.check(request: request)
    }
}
