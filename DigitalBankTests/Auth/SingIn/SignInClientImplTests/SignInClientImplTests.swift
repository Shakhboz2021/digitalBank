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
    
    func test_signIn_propagatesNon2xxAsNetworkError() async {
            // Arrange
        let network = NetworkSessionSpy()
        let endpoint: Endpoint = AuthEndpoint.signIn
        let sut = SignInClientImpl(network: network, endpoint: endpoint)
        
        let data = Data()
        let response = HTTPTest.response(endpoint: endpoint, status: 401) // ⬅️ sizdagi helper
        network.result = .success((data, response))
        
        let dto = SignInDTO.Request.mock
        
            // Act & Assert
        do {
            _ = try await sut.signIn(request: dto)
            XCTFail("Expected to throw NetworkError.non2xx, but got success")
        } catch let error as NetworkError {
            guard case let .non2xx(status) = error else {
                return XCTFail("Expected .non2xx, got \(error)")
            }
            XCTAssertEqual(status, 401)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
        
        XCTAssertEqual(network.receivedRequests.count, 1)
    }
    
}
