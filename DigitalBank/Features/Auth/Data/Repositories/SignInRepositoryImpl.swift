//
//  SignInRepositoryImpl.swift
//  DigitalBank
//
//  Created by Muhammad on 02/09/25.
//

import Foundation

class SignInRepositoryImpl: SignInRepository {
    private let client: SignInClient

    init(client: SignInClient) { self.client = client }
    func signIn(request: SignInModels.Request) async throws
        -> SignInModels.Response
    {
        let dtoRequest = request.toDTO()
        let dtoResponse = try await client.check(request: dtoRequest)
        return dtoResponse.toDomain()
    }
}
