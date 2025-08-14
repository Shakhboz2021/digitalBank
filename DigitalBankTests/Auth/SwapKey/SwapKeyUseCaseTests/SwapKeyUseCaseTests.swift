//
//  SwapKeyUseCaseTests.swift
//  DigitalBankTests
//
//  Created by Muhammad on 08/08/25.
//

import XCTest
@testable import DigitalBank

final class SwapKeyUseCaseTests: XCTestCase {
    // Sad cases
    func test_init_doesNotSendRequest() async {
        let repo = SwapKeyRepositorySpy()
        _ = SwapKeyUseCaseImpl(repository: repo) // init
        
        XCTAssertTrue(repo.receivedRequests.isEmpty)
    }
    
    func test_execute_shouldThrowError_whenClientFails() async {
        // Given
        let repo = SwapKeyRepositorySpy()
        let useCase = SwapKeyUseCaseImpl(repository: repo)
        
        let expectedError = NSError(domain: "Test", code: 1)
        repo.resultToReturn = .failure(expectedError)
        
        // When & Then
        do {
            _ = try await useCase.execute(request: .mock)
            XCTFail("Expected to throw but did not")
        } catch {
            XCTAssertEqual(error as NSError, expectedError)
        }
        
    }
    
    // Happy case
    func test_excute_shouldReturnResponse_whenClientSucceeds() async throws {
        // Given
        let repo = SwapKeyRepositorySpy()
        let expectedResponse = SwapKeyModels.Response.mock
        repo.resultToReturn = .success(expectedResponse)
        let sut = SwapKeyUseCaseImpl(repository: repo)
        
        // When
        let result = try await sut.execute(request: .mock)
        
        // Then
        XCTAssertEqual(result, expectedResponse)
        XCTAssertEqual(repo.receivedRequests, [.mock])
    }
    
}
