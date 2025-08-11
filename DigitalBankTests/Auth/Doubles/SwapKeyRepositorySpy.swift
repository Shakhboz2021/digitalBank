//
//  SwapKeyRepositorySpy.swift
//  DigitalBankTests
//
//  Created by Muhammad on 11/08/25.
//

import Foundation

@testable import DigitalBank

class SwapKeyRepositorySpy: SwapKeyRepository {
    private(set) var receivedRequests: [SwapKeyModels.Request] = []
    var resultToReturn: Result<SwapKeyModels.Response, Error>?

    func swapKey(request: SwapKeyModels.Request) async throws
        -> SwapKeyModels.Response
    {
        receivedRequests.append(request)
        switch resultToReturn {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        case .none:
            fatalError("Set resultToReturn before calling swapKey()")
        }
    }

}
