//
//  SpySwapKeyClient.swift
//  DigitalBank
//
//  Created by Muhammad on 06/08/25.
//

import Foundation

final class SwapKeyClientSpy: SwapKeyClient {
    private(set) var receivedRequests: [SwapKeyModels.Request] = []
    var resultToReturn: SwapKeyModels.Response?

    func send(request: SwapKeyModels.Request) async throws -> SwapKeyModels.Response {
        receivedRequests.append(request)
        return resultToReturn ?? .init()
    }
}
