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
    func test_signIn_propagatesClientError() async {
        // Arrange
        let (sut, client) = makeSUT()
        let request: SignInModels.Request = .mock
        let expected = NetworkError.non2xx(status: 401)
        client.result = .failure(expected)
        
        // Act & Assert
        do {
            _ = try await sut.signIn(request: request)
            XCTFail("Expecterd to throw \(expected)")
        } catch let error as NetworkError {
            guard case let .non2xx(status) = error else {
                return XCTFail("Expecterd to throw .non2xx, got \(error)")
            }
            XCTAssertEqual(status, 401)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
        XCTAssertEqual(client.callCounter, 1)
        XCTAssertEqual(client.receivedRequests.count, 1)
    }
}
