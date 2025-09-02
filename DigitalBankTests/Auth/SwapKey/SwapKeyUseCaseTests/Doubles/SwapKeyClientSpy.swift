//
//  SwapKeyClientSpy.swift
//  DigitalBankTests
//
//  Created by Muhammad on 08/08/25.
//

import Foundation

@testable import DigitalBank

final class SwapKeyClientSpy: SwapKeyClient {
    private(set) var receivedRequests: [SwapKeyDTO.Request] = []
    var resultToReturn: Result<SwapKeyDTO.Response, Error>?

    func send(request: SwapKeyDTO.Request) async throws
    -> SwapKeyDTO.Response
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
