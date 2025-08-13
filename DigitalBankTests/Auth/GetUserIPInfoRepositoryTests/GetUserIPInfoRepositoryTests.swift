//
//  GetUserIPInfoRepositoryTests.swift
//  DigitalBankTests
//
//  Created by Muhammad on 13/08/25.
//

import XCTest
@testable import DigitalBank

final class GetUserIPInfoRepositoryTests: XCTestCase {
    func test_init_doesNotRequestFromClient() {
        // Given
        let client = GetUserIPInfoClientSpy()
        // When
        _ = GetUserIPInfoRepositoryImpl(client: client)
        // Then
        XCTAssertTrue(client.receivedRequests.isEmpty)
    }
}
