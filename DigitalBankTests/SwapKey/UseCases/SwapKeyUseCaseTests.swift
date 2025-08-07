//
//  SwapKeyUseCaseTests.swift
//  DigitalBank
//
//  Created by Muhammad on 06/08/25.
//

import XCTest
@testable import DigitalBank

class SwapKeyUseCaseTests: XCTestCase {
    
    func test_init_doesNotSendRequest() {
        let (_, client) = makeSUT()
        XCTAssertTrue(client.receivedRequests.isEmpty)
    }
    
}

extension SwapKeyUseCaseTests {
    func makeSUT() -> (SwapKeyUseCase, SwapKeyClientSpy) {
        let client = SwapKeyClientSpy()
        let repository = SwapKeyRepositoryImpl(client: client)
        let sut = SwapKeyUseCase(repository: repository)
        return (sut, client)
    }
}

