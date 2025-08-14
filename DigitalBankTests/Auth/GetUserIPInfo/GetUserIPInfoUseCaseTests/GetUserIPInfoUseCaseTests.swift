//
//  GetIPUseCaseTests.swift
//  DigitalBankTests
//
//  Created by Muhammad on 12/08/25.
//

import XCTest
@testable import DigitalBank

class GetUserIPInfoUseCaseTests: XCTestCase {
    // What + When + From/Where
    func test_init_doesNotRequestIPFromRepository() {
        let (_, repo) = makeSUIT()
        
        XCTAssertTrue(repo.receivedRequests.isEmpty)
    }
    
    func test_execute_propogateRepositoryError() async {
        let (suit, repo) = makeSUIT()
        let expectedError = NSError(domain: "Test", code: 1)
        
        await expect(suit, repo: repo, toCompleteWith: .failure(expectedError))
    }
    
    // Happy case tests
    func test_execute_deliversUserIPInfoOnSuccess() async {
        let (suit, repo) = makeSUIT()
        let expected: UserIPInfo = .mock
        
        await expect(suit, repo: repo, toCompleteWith: .success(expected))
    }
}
