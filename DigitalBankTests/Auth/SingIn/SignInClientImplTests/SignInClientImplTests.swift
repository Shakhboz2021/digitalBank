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
    let network = NetworkSessionSpy()
    let endpoint: Endpoint = AuthEndpoint.signIn
    func test_init_doesNotHitNetwirk() {
        // Act
        _ = SignInClientImpl(network: network, endpoint: endpoint)

        // Assert
        XCTAssertTrue(network.receivedRequests.isEmpty)
    }
    // MARK: - Sad-case tests
    func test_signIn_propagatesNon2xxAsNetworkError() async {
        // Arrange
        let sut = SignInClientImpl(network: network, endpoint: endpoint)

        let data = Data()
        let response = HTTPTest.response(endpoint: endpoint, status: 401)  // ⬅️ sizdagi helper
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

    func test_signIn_propagatesDecodingFailedOnInvalidJSON() async {
        // Arrange
        let sut = SignInClientImpl(network: network, endpoint: endpoint)

        // notog'ri JSON (decode qilib bo'lmaydi)
        let badJSON = Data("not-json".utf8)
        let http = HTTPTest.response(endpoint: endpoint, status: 200)
        network.result = .success((badJSON, http))

        let dto = SignInDTO.Request.mock

        // Act & Assert
        do {
            _ = try await sut.signIn(request: dto)
            XCTFail(
                "Expected to throw NetworkError.decodingFailed, but got success"
            )
        } catch let NetworkError.decodingFailed(underlying) {
            XCTAssertTrue(underlying is DecodingError)  // yoki (underlying as? NSError) != nil
        } catch {
            XCTFail("Unexpected error: \(error)")
        }

        XCTAssertEqual(network.receivedRequests.count, 1)
    }

    // MARK: - Happy-case tests
    func test_signIn_deliversDTOResponseOn200() async throws {
        // Arrange
        let network = NetworkSessionSpy()
        let endpoint: Endpoint = AuthEndpoint.signIn
        let sut = SignInClientImpl(network: network, endpoint: endpoint)

        let expectedDTO = SignInDTO.Response.mock
        let ok = HTTPTest.response(endpoint: endpoint, status: 200)
        let okData = try JSONEncoder().encode(expectedDTO)
        network.result = .success((okData, ok))

        let dtoReq = SignInDTO.Request.mock

        // Act
        let received = try await sut.signIn(request: dtoReq)

        // Assert
        XCTAssertEqual(received, expectedDTO)
        XCTAssertEqual(network.receivedRequests.count, 1)
    }
}
