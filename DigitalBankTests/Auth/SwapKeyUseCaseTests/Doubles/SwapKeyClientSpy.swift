//
//  SwapKeyClientSpy.swift
//  DigitalBankTests
//
//  Created by Muhammad on 08/08/25.
//

import Foundation

@testable import DigitalBank

final class SwapKeyClientSpy: SwapKeyClient {
    private(set) var receivedRequests: [SwapKeyModels.Request] = []
    var resultToReturn: Result<SwapKeyModels.Response, Error>?

    func send(request: SwapKeyModels.Request) async throws
        -> SwapKeyModels.Response
    {
        receivedRequests.append(request)
        switch resultToReturn {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        case .none:
            fatalError("Spy resultToReturn must be set before calling send()")
        }
    }

}
