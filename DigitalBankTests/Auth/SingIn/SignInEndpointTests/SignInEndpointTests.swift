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

    func test_signIn_setsDefaultHeaders() throws {
        let request = try sut.makeRequest()
        XCTAssertEqual(
            request.value(forHTTPHeaderField: "Accept"),
            "application/json"
        )
        XCTAssertEqual(
            request.value(forHTTPHeaderField: "Content-Type"),
            "application/json"
        )
        XCTAssertEqual(request.value(forHTTPHeaderField: "lang"), "uz")
        XCTAssertEqual(request.value(forHTTPHeaderField: "device"), "I")
        // Dynamic headerlar — faqat mavjudligini tekshiramiz
        XCTAssertNotNil(request.value(forHTTPHeaderField: "Authorization"))
        XCTAssertNotNil(request.value(forHTTPHeaderField: "devicecode"))
    }

    func test_signIn_hasNoBody_whenNilPassed() throws {
        let request = try sut.makeRequest()
        XCTAssertNil(request.httpBody)
    }

    func test_signIn_absoluteURL_isCorrect() throws {
        let request = try sut.makeRequest()
        XCTAssertEqual(
            request.url?.absoluteString,
            sut.url.absoluteString
        )
    }
}
