//
//  SignInClientSpy.swift
//  DigitalBankTests
//
//  Created by Muhammad on 03/09/25.
//

import Foundation

@testable import DigitalBank

final class SignInClientSpy: SignInClient {
    // Observability
    private(set) var receivedRequests: [SignInDTO.Request] = []
    var result: Result<SignInDTO.Response, Error>?

    // Call count
    var callCounter = 0
    func signIn(request: DigitalBank.SignInDTO.Request) async throws
        -> DigitalBank.SignInDTO.Response
    {
        callCounter += 1
        receivedRequests.append(request)

        if let result {
            switch result {
            case .success(let dto):
                return dto
            case .failure(let error):
                throw error
            }
        }
        throw NSError(domain: "SignInClientSpy.result not set", code: -1)
    }
}
