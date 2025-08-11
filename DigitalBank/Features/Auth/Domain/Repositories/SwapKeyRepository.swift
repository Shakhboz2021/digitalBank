//
//  SwapKeyRepository.swift
//  DigitalBank
//
//  Created by Muhammad on 11/08/25.
//

import Foundation

protocol SwapKeyRepository {
    func swapKey(request: SwapKeyModels.Request) async throws
        -> SwapKeyModels.Response
}
