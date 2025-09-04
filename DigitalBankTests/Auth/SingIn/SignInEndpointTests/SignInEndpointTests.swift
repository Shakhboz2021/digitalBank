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
    // Arrange
    let sut: Endpoint = AuthEndpoint.signIn

    func test_signIn_hasPostMethod() throws {
        // Act
        let request = try sut.makeRequest()
        // Assert
        XCTAssertEqual(request.httpMethod, HTTPMethod.post.rawValue)
    }
    
    func test_signIn_hasExpectedPath() throws {
        let request = try sut.makeRequest()
        XCTAssertEqual(request.url?.path, "/USER_SIGN_IN_NEW")
    }
}
