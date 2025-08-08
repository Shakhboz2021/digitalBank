//
//  SwapKeyUseCaseTests.swift
//  DigitalBankTests
//
//  Created by Muhammad on 08/08/25.
//

import XCTest
@testable import DigitalBank

final class SwapKeyUseCaseTests: XCTestCase {
    
    func test_init_doesNotSendRequest() async {
        let client = SwapKeyClientSpy()
        _ = SwapKeyUseCaseImpl(client: client) // init
        
        XCTAssertTrue(client.receivedRequests.isEmpty)
    }
    
    func test_execute_shouldThrowError_whenClientFails() async {
        // Given
        let client = SwapKeyClientSpy()
        let useCase = SwapKeyUseCaseImpl(client: client)
        
        let expectedError = NSError(domain: "Test", code: 1)
        client.resultToReturn = .failure(expectedError)
        
        // Whem & Then
        do {
            _ = try await useCase.execute(request: .mock)
            XCTFail("Expected to throw but did not")
        } catch {
            XCTAssertEqual(error as NSError, expectedError)
        }
        
    }
}
