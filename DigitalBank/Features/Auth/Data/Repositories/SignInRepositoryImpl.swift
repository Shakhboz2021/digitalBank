//
//  SignInRepositoryImpl.swift
//  DigitalBank
//
//  Created by Muhammad on 02/09/25.
//

import Foundation
class SignInRepositoryImpl: SignInRepository {
    private let client: SignInClient
    
    init(client: SignInClient) {
        self.client = client
    }
    func check(request: SignInModels.Request) async throws -> SignInModels.Response {
        try await client.check(request: request)
    }
}
