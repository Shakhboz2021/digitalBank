//
//  SignInClientImplTests.swift
//  DigitalBankTests
//
//  Created by Muhammad on 04/09/25.
//

import Foundation
import XCTest
@testable import DigitalBank

final class SignInClientImplTests: XCTestCase {
    
    func test_init_doesNotHitNetwirk() {
        // Arrange
        let network = NetworkSessionSpy()
        let endpoint: Endpoint = AuthEndpoint.signIn
        
        // Act
        _ = SignInClientImpl(network: network, endpoint: endpoint)
        
        // Assert
        XCTAssertTrue(network.receivedRequests.isEmpty)
    }
}
