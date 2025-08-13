//
//  GetUserIPInfoRepositorySpy.swift
//  DigitalBankTests
//
//  Created by Muhammad on 12/08/25.
//

import Foundation

@testable import DigitalBank

class GetUserIPInfoRepositorySpy: GetUserIPInfoRepository {
    private(set) var receivedRequests: [Void] = []
    var resultToReturn: Result<UserIPInfo, Error>?

    func getUserIPInfo() async throws -> DigitalBank.UserIPInfo {
        receivedRequests.append(())
        switch resultToReturn {
        case .success(let info):
            return info
        case .failure(let error):
            throw error
        case .none:
            fatalError(
                "resultToReturn must be initialized before calling getUserIPInfo()"
            )
        }
    }

}
