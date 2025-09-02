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
    
    func test_execute_propogatesRepositoryError() async {
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
}
