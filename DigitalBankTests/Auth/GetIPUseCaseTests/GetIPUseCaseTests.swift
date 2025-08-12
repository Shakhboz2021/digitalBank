//
//  GetIPUseCaseTests.swift
//  DigitalBankTests
//
//  Created by Muhammad on 12/08/25.
//

import XCTest
@testable import DigitalBank

class GetIPUseCaseTests: XCTestCase {
    // What + When + From/Where
    func test_init_doesNotRequestIPFromRepository() {
        // MARK: - Given
        let repo = GetIPRepositorySpy()
        
        // MARK: - When
        _ = GetIPUseCaseImpl(repository: repo)
        
        //MARK: - Then
        XCTAssertTrue(repo.receivedRequests.isEmpty)
    }
}
