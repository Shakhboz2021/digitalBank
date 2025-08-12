//
//  GetIPUseCaseTests.swift
//  DigitalBankTests
//
//  Created by Muhammad on 12/08/25.
//

import XCTest
@testable import DigitalBank

class GetUserIPInfoUseCaseTests: XCTestCase {
    // What + When + From/Where
    func test_init_doesNotRequestIPFromRepository() {
        // MARK: - Given
        let repo = GetUserIPInfoRepositorySpy()
        
        // MARK: - When
        _ = GetUserIPInfoUseCaseImpl(repository: repo)
        
        //MARK: - Then
        XCTAssertTrue(repo.receivedRequests.isEmpty)
    }
}
