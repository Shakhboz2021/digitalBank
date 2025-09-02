//
//  SignInUseCaseTests.swift
//  DigitalBankTests
//
//  Created by Muhammad on 02/09/25.
//

import Foundation
import XCTest

@testable import DigitalBank

class SignInUseCaseTests: XCTestCase {
    func test_init_doesNotCallRepository() {
        let repo = SignInRepositorySpy()
        _ = SignInUseCaseImpl(repository: repo)
        XCTAssertEqual(repo.checkCallCount, 0)
        XCTAssertTrue(repo.receivedRequests.isEmpty)
    }
}
