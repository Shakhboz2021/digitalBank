//
//  SpySwapKeyClient.swift
//  DigitalBank
//
//  Created by Muhammad on 06/08/25.
//

import Foundation

final class SwapKeyClientSpy: SwapKeyClient {
    private(set) var receivedRequests: [SwapKeyModels.Request] = []
    var resultToReturn: Result<SwapKeyModels.Response, Error> = .failure(
        URLError(.notConnectedToInternet)
    )

    func send(request: SwapKeyModels.Request) async throws -> SwapKeyModels.Response {
        receivedRequests.append(request)

        switch resultToReturn {
        case .success(let response): return response
        case .failure(let error): throw error
        }
    }
}
