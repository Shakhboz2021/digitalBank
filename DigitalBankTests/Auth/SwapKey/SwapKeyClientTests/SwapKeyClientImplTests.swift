//
//  SwapKeyClientImplTests.swift
//  DigitalBankTests
//
//  Created by Muhammad on 14/08/25.
//

import XCTest
@testable import DigitalBank

final class SwapKeyClientImplTests: XCTestCase {

    // MARK: - Test fixtures (per-test reinit)
    private var spy: NetworkSessionSpy!
    private var url: URL!
    private var sut: SwapKeyClientImpl!

    override func setUp() {
        super.setUp()
        spy = NetworkSessionSpy()
        url = URL(string: "https://any-url.com/swap-key")!
        sut = SwapKeyClientImpl(network: spy, url: url)
    }
    
    override func tearDown() {
        spy = nil
        url = nil
        sut = nil
        super.tearDown()
    }
    
    func test_init_doesNotRequestAnyData() {
        _ = SwapKeyClientImpl(
            network: spy,
            url: url
        )
        XCTAssertEqual(spy.receivedRequests.count, 0)
    }

    func test_swapKey_propogatesNetworkError() async {
        // Given
        let expectedError = URLError(.timedOut)
        spy.result = .failure(expectedError)

        // When & Then

        do {
            _ = try await sut.send(request: .mock)
            XCTFail("Expected to throw, go success")
        } catch {
            XCTAssertEqual((error as? URLError)?.code, expectedError.code)
        }

    }

    func test_swapKey_deliversResponseOn200() async throws {
        // (Arrange)Given
        let expectedDTO = SwapKeyDTO.Response.mock
        let data = try JSONEncoder().encode(expectedDTO)
        guard
            let http = HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]
            )
        else {
            XCTFail("Failed to create HTTPURLResponse")
            return
        }
        spy.result = .success((data, http))

        // (Act)When
        let received = try await sut.send(request: .mock)

        // (Assert)Then
        XCTAssertEqual(received, expectedDTO.toDomain())
        XCTAssertEqual(spy.receivedRequests.count, 1)
    }

}
