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

    func test_execute_propogateClientError() async throws {
        // Given
        let client = GetUserIPInfoClientSpy()
        let sut = GetUserIPInfoRepositoryImpl(client: client)
        let expectedError = NSError(domain: "Test", code: 1)
        client.resultToReturn = .failure(expectedError)
        //When & Then
        do {
            _ = try await sut.getUserIPInfo()
            XCTFail("Expected to fail but successed")
        } catch {
            XCTAssertEqual((error as NSError).domain, expectedError.domain)
            XCTAssertEqual((error as NSError).code, expectedError.code)
        }
    }
}
