//
//  SwapKeyClientImplTests.swift
//  DigitalBankTests
//
//  Created by Muhammad on 14/08/25.
//

import XCTest
@testable import DigitalBank

class SwapKeyClientImplTests: XCTestCase {
    
    func test_init_doesNotRequestAnyData() {
        let spy = NetworkSessionSpy()
        _ = SwapKeyClientImpl(network: spy, url: URL(string: "https://any-url.com")!)
        XCTAssertEqual(spy.receivedRequests.count, 0)
    }
    
    func test_swapKey_propogatesNetworkError() async {
        // Given
        let spy = NetworkSessionSpy()
        let url = URL(string: "https://any-url.com")!
        let sut = SwapKeyClientImpl(network: spy, url: url)
        
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
    
    func test_swapKey_deliversResponseOn200() async {
        // Given
        let spy = NetworkSessionSpy()
        let url = URL(string: "https://any-url.com")!
        let sut = SwapKeyClientImpl(network: spy, url: url)
        
        let expectedDTO = SwapKeyDTO.Response.mock
        let data = try JSONEncoder().encode(expectedDTO)
        let http = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: ["Content-Type": "application/json"]
        )
        spy.result = .success((data, http))
        
        // When
        let received = try await sut.send(request: .mock)
        
        // Then
        XCTAssertEqual(received, expectedDTO)
        XCTAssertEqual(spy.receivedRequests.count, 1)
    }
    
}
