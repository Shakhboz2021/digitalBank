//
//  SignInRepositorySpy.swift
//  DigitalBankTests
//
//  Created by Muhammad on 02/09/25.
//

import Foundation

@testable import DigitalBank

class SignInRepositorySpy: SignInRepository {

    //MARK: - Observability
    private(set) var receivedRequests: [SignInModels.Request] = []
    var result: Result<SignInModels.Response, Error>?

    //MARK: - call count for verifying exactly-once semantics
    private(set) var checkCallCount = 0

    // MARK: - Protocol
    func signIn(request: DigitalBank.SignInModels.Request) async throws
        -> DigitalBank.SignInModels.Response
    {
        checkCallCount += 1
        receivedRequests.append(request)

        if let result {
            switch result {
            case .success(let response):
                return response
            case .failure(let error):
                throw error
            }
        }

        // Default: prevent silent pass - makes tests explicit
        throw NSError(domain: "SignInRepositorySpy.result not set", code: -1)
    }

}
