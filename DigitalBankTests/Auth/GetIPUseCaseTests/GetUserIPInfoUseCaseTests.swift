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
        let (_, repo) = makeSUIT()
        
        XCTAssertTrue(repo.receivedRequests.isEmpty)
    }
}
