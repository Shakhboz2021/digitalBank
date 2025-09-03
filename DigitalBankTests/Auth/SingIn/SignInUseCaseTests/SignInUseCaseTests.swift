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
    
    // MARK: - Baby stage
    func test_init_doesNotCallRepository() {
        let repo = SignInRepositorySpy()
        _ = SignInUseCaseImpl(repository: repo)
        XCTAssertEqual(repo.checkCallCount, 0)
        XCTAssertTrue(repo.receivedRequests.isEmpty)
    }
    // MARK: - Sad-case tests
    func test_execute_propagatesRepositoryError() async {
        // Arrange
        let (sut, repo) = makeSUT()
        let request = makeSignInRequest()

        // Assign & Assert
        do {
            _ = try await sut.execute(request: request)
            XCTFail("Expected to throw because spy.result is nil")
        } catch {
            let nsError = error as NSError
            XCTAssertEqual(nsError.domain, "SignInRepositorySpy.result not set")
            XCTAssertEqual(repo.checkCallCount, 1)
            XCTAssertEqual(repo.receivedRequests.count, 1)
        }
    }

    func test_execute_propagatesNetworkErrorOn401() async {
        // Arrange
        let (sut, repo) = makeSUT()
        let request = makeSignInRequest()
        let expected = NetworkError.non2xx(status: 401)

        repo.result = .failure(expected)

        // Act & Assert
        do {
            _ = try await sut.execute(request: request)
            XCTFail("Expected to throw \(expected), but got success")
        } catch let error as NetworkError {
            guard case let .non2xx(status) = error else {
                return XCTFail("Expected to throw .non2xx, but got \(error)")
            }
            XCTAssertEqual(status, 401)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
        XCTAssertEqual(repo.checkCallCount, 1)
        XCTAssertEqual(repo.receivedRequests.count, 1)
    }
    
    func test_execute_propagatesDecodingFailedError() async {
        // Arrange
        let (sut, repo) = makeSUT()
        let request = makeSignInRequest()
        let underlyingError = NSError(domain: "decode", code: 0)
        let expected = NetworkError.decodingFailed(underlying: underlyingError)
        
        repo.result = .failure(expected)
        
        // Act & Assert
        do {
            _ = try await sut.execute(request: request)
            XCTFail("Unexpected to throw, but got success")
        } catch let error as NetworkError {
            guard case let .decodingFailed(underlying) = error else {
                return XCTFail("Expected to throw .decoding, but got \(error)")
            }
            XCTAssertEqual((underlying as? NSError)?.domain, "decode")
        } catch {
            XCTAssertEqual(repo.checkCallCount, 1)
            XCTAssertEqual(repo.receivedRequests.count, 1)
        }
    }
    
    // MARK: - Happy-case tests
    func test_execute_deliversResponseOnSuccess() async throws {
        // Arrange
        let (sut, repo) = makeSUT()
        let request = makeSignInRequest()
        
        let expected = makeSignInResponse()
        repo.result = .success(expected)
        
        // Act
        let result = try await sut.execute(request: request)
        
        // Assert
        XCTAssertEqual(result, expected)
        XCTAssertEqual(repo.checkCallCount, 1)
        XCTAssertEqual(repo.receivedRequests.count, 1)
        
    }
}
