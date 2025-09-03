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
    private var endpoint: Endpoint = AuthEndpoint.swapKey
    private var sut: SwapKeyClientImpl!

    override func setUp() {
        super.setUp()
        spy = NetworkSessionSpy()
        sut = SwapKeyClientImpl(network: spy, endpoint: endpoint)
    }

    override func tearDown() {
        spy = nil
        sut = nil
        super.tearDown()
    }

    
    
    func test_init_doesNotRequestAnyData() {
        _ = SwapKeyClientImpl(
            network: spy,
            endpoint: endpoint
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
        } catch let error as NetworkError {
            switch error {
            case .transport(let underlying):
                // ixtiyoriy: underlying URLError code ni ham tekshirish mumkin
                XCTAssertEqual(
                    (underlying as? URLError)?.code,
                    expectedError.code
                )
            default:
                XCTFail("Unexpected error \(error)")
            }
        } catch {
            XCTFail("Unexpected error type \(error)")
        }

    }

    func test_swapKey_failsOnHTTP400() async {
        // AAA
        // MARK: - Arrange
        let body = Data(#"{"code":400,"msg":"Bad Request"}"#.utf8)
        let http = HTTTPTest.response(endpoint: endpoint, status: 400)
        spy.result = .success((body, http))

        // MARK: - Act & Assert
        do {
            _ = try await sut.send(request: .mock)
            XCTFail("Expected to throw, go success")
        } catch let error as NetworkError {
            switch error {
            case .non2xx(let status):
                XCTAssertEqual(status, 400)
            default:
                XCTFail("Expected .non2xx, got \(error)")
            }
            XCTAssertEqual(spy.receivedRequests.count, 1)
        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }

    func test_swapKey_failsOnHTTP500() async {
        // AAA
        // MARK: - Arrange
        let body = Data(#"{"code":500,"msg":"Bad Request"}"#.utf8)
        let http = HTTTPTest.response(endpoint: endpoint, status: 500)
        spy.result = .success((body, http))

        // MARK: - Act & Assert
        do {
            _ = try await sut.send(request: .mock)
            XCTFail("Expected to throw, go success")
        } catch let error as NetworkError {
            switch error {
            case .non2xx(let status):
                XCTAssertEqual(status, 500)
            default:
                XCTFail("Expected .non2xx, got \(error)")
            }
            XCTAssertEqual(spy.receivedRequests.count, 1)
        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }

    func test_swapKey_deliversResponseOn200() async throws {
        // (Arrange)Given
        let expectedDTO = SwapKeyDTO.Response.mock
        let data = try JSONEncoder().encode(expectedDTO)
        let http = HTTTPTest.response(endpoint: endpoint, status: 200)
        spy.result = .success((data, http))

        // (Act)When
        let received = try await sut.send(request: .mock)

        // (Assert)Then
        XCTAssertEqual(received, expectedDTO)
        XCTAssertEqual(spy.receivedRequests.count, 1)
    }

    func test_send_encodesRequestBodyWithDTO() async throws {
        // Arrange
        let expectedDTO = SwapKeyDTO.Request.mock
        // Network javobi kerak emas; faqat body tekshiramiz
        let okBody = try JSONEncoder().encode(SwapKeyDTO.Response.mock)  // Data
        let ok = HTTTPTest.response(
            endpoint: endpoint,
            status: 200
        )  // HTTPURLResponse
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
        let sentJson = try JSONSerialization.jsonObject(
            with: body,
            options: []
        ) as! NSDictionary
        let expectedJson = try JSONSerialization.jsonObject(
            with: expectedBody,
            options: []
        ) as! NSDictionary
        XCTAssertEqual(sentJson, expectedJson)

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

        let okResponse = HTTTPTest.response(endpoint: endpoint, status: 200)
        let okBody = try customEncoder.encode(SwapKeyDTO.Response.mock)
        spy.result = .success((okBody, okResponse))

        let sut = SwapKeyClientImpl(
            network: spy,
            endpoint: endpoint,
            encoder: customEncoder,
            decoder: customDecoder
        )

        // Act
        _ = try await sut.send(request: .mock)

        // Assert
        guard let sent = spy.receivedRequests.first else {
            return XCTFail("No request sent")
        }
        let sentJson = try JSONSerialization.jsonObject(
            with: sent.httpBody!
        ) as! NSDictionary
        let expectedJson = try JSONSerialization.jsonObject(with: encodedBody) as!NSDictionary
        
        XCTAssertEqual(sentJson, expectedJson)
    }

    // Transport level tests
    func test_send_returnsTransportErrorOnURLSessionTimeout() async {
        // Arrange
        spy.result = .failure(URLError(.timedOut))

        // Act
        do {
            _ = try await sut.send(request: .mock)
            XCTFail("Expected transport error, got success")
        } catch let error as NetworkError {
            // Assert (pattern matching — Equatable talab qilmaydi)
            switch error {
            case .transport:
                XCTAssertTrue(true)
            default:
                XCTFail("Expected .transport, got \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func test_send_returnsTransportErrorOnNoInternet() async {
        // Arrange
        spy.result = .failure(URLError(.notConnectedToInternet))

        // Act
        do {
            _ = try await sut.send(request: .mock)
            XCTFail("Expected transport error, got success")
        } catch let error as NetworkError {
            switch error {
            case .transport:
                XCTAssertTrue(true)
            default:
                XCTFail("Expected .transport, got \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

}
