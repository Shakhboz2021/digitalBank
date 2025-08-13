//
//  GetUserIPClientSpy.swift
//  DigitalBankTests
//
//  Created by Muhammad on 13/08/25.
//

import Foundation
@testable import DigitalBank

class GetUserIPInfoClientSpy: GetUserIPInfoClient {
    private(set) var receivedRequests: [Void] = []
    var resultToReturn: Result<UserIPInfoDTO, Error>?
    
    func fetchUserIPInfo() async throws -> UserIPInfoDTO {
        receivedRequests.append(())
        switch resultToReturn {
            case .success(let userIPInfoDTO):
                return userIPInfoDTO
            case .failure(let error):
                throw error
            case .none:
                fatalError("Set resultToReturn before calling fetchUserIPInfo()")
        }
    }

    
}
