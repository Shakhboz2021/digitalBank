//
//  SignInRepositoryTests.swift
//  DigitalBankTests
//
//  Created by Muhammad on 03/09/25.
//

import Foundation
import XCTest

@testable import DigitalBank

class SignInRepositoryTests: XCTestCase {
    // MARK: - Initial
    func test_init_doesNotCallClient() {
        let (_, client) = makeSUT()

        XCTAssertEqual(client.callCounter, 0)
        XCTAssertTrue(client.receivedRequests.isEmpty)
    }
    // MARK: - Sad-case tests
    
}
