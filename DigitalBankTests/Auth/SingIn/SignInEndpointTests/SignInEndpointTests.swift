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

    func test_signIn_encodesBodyCorrectly() throws {
        let dto = SignInDTO.Request(
            clientId: "id",
            phoneNumber: "998901234567",
            deviceType: "I",
            deviceCode: "device-code",
            deviceName: "iPhone",
            version: "1.0",
            password: "secret",
            isPin: false,
            appVersionCode: "100",
            osVersion: "18.0",
            appVersion: "1.0.0",
            osSystemVersionApi: "iOS18",
            userInfo: .mock
        )
        
        let request = try sut.makeRequest(body: dto)
        
        let bodyData = try XCTUnwrap(request.httpBody)
        let decodedBody = try JSONDecoder().decode(SignInDTO.Request.self, from: bodyData)
        
        XCTAssertEqual(decodedBody, dto)

    }
    
    func test_signIn_includesQueryItems() throws {
        // Arrange
        struct QueryEndpoint: Endpoint {
            let url = URL(string: "https://example.com/api")!
            let method: HTTPMethod = .get
            let query: [URLQueryItem] = [
                URLQueryItem(name: "q", value: "search"),
                URLQueryItem(name: "page", value: "2")
            ]
        }
        let endpoint = QueryEndpoint()
        // Act
        let request = try endpoint.makeRequest()
        
        // Assert
        let absoluteURL = try XCTUnwrap(request.url?.absoluteString)
        XCTAssertTrue(absoluteURL.contains("q=search"))
        XCTAssertTrue(absoluteURL.contains("page=2"))
    }
}
