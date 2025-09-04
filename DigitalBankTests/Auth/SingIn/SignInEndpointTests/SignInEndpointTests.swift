//
//  SignInEndpointTests.swift
//  DigitalBankTests
//
//  Created by Muhammad on 04/09/25.
//

import Foundation
import XCTest

@testable import DigitalBank

class SignInEndpointTests: XCTestCase {
    func test_signIn_hasPostMethod() throws {
        // Arrange
        let sut: Endpoint = AuthEndpoint.signIn
        // Act
        let request = try sut.makeRequest()
        // Assert
        XCTAssertEqual(request.httpMethod, HTTPMethod.post.rawValue)
    }
}
