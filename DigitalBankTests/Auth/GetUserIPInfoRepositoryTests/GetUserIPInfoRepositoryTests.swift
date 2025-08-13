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

    func test_getUserIPInfo_propogateClientError() async throws {
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
    
    func test_getUserIPInfo_deliversDomainModelOnSuccess() async throws {
        // Given
        let client = GetUserIPInfoClientSpy()
        let sut = GetUserIPInfoRepositoryImpl(client: client)
        client.resultToReturn = .success(.mock)
        // When
        let received = try await sut.getUserIPInfo()
        //Then
        XCTAssertEqual(received, UserIPInfoDTO.mock.toDomain())
        XCTAssertEqual(client.receivedRequests.count, 1)
    }
}
