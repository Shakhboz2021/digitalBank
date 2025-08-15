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

    func test_swapKey_failsOnHTTP400() async {
        // AAA
        // MARK: - Arrange
        let body = Data(#"{"code":400,"msg":"Bad Request"}"#.utf8)
        let http = HTTTPTest.response(url: url, status: 400)
        spy.result = .success((body, http))

        // MARK: - Act & Assert
        do {
            _ = try await sut.send(request: .mock)
            XCTFail("Expected error on 400, but get success")
        } catch {
            XCTAssertEqual((error as? URLError)?.code, .badServerResponse)
            XCTAssertEqual(spy.receivedRequests.count, 1)
        }
    }

    func test_swapKey_failsOnHTTP500() async {
        // AAA
        // MARK: - Arrange
        let body = Data(#"{"code":500,"msg":"Bad Request"}"#.utf8)
        let http = HTTTPTest.response(url: url, status: 500)
        spy.result = .success((body, http))

        // MARK: - Act & Assert
        do {
            _ = try await sut.send(request: .mock)
            XCTFail("Expected error on 500, but get success")
        } catch {
            XCTAssertEqual((error as? URLError)?.code, .badServerResponse)
            XCTAssertEqual(spy.receivedRequests.count, 1)
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

    func test_send_encodesRequestBodyWithDTO() async throws {
        // Arrange
        let expectedDTO = SwapKeyDTO.Request.mock
        // Network javobi kerak emas; faqat body tekshiramiz
        let okBody = try JSONEncoder().encode(SwapKeyDTO.Response.mock) // Data
        let ok = HTTTPTest.response(url: url, status: 200) // HTTPURLResponse
        spy.result = .success((okBody, ok))

        // Act
        _ = try await sut.send(request: .mock)

        // Assert
        guard let sent = spy.receivedRequests.first, let body = sent.httpBody
        else {
            return XCTFail("No request sent or body is nil")
        }

        let expectedBody = try JSONEncoder().encode(expectedDTO)

        // JSON byte-for-byte tengligini tekshiramiz
        XCTAssertEqual(body, expectedBody)

        // (ixtiyoriy) Header va method ham to‘g‘ri
        XCTAssertEqual(sent.httpMethod, "POST")
        XCTAssertEqual(
            sent.value(forHTTPHeaderField: "Content-Type"),
            "application/json"
        )
    }
    
    func test_send_usesInjectedEncoderDecoder() async throws {
        // Arrange
        let customEncoder = JSONEncoder()
        let customDecoder = JSONDecoder()
        
        let expectedDTO = SwapKeyDTO.Request.mock
        let encodedBody = try customEncoder.encode(expectedDTO)
        
        let okResponse = HTTTPTest.response(url: url, status: 200)
        let okBody = try customEncoder.encode(SwapKeyDTO.Request.mock)
        spy.result = .success((okBody, okResponse))
        
        let sut = SwapKeyClientImpl(
            network: spy,
            url: url,
            encoder: customEncoder, decoder: customDecoder
        )
        
        // Act
        _ = try await sut.send(request: .mock)
        
        // Assert
        guard let sent = spy.receivedRequests.first else {
            return XCTFail("No request sent")
        }
        XCTAssertEqual(sent.httpBody, encodedBody)
    }

}
