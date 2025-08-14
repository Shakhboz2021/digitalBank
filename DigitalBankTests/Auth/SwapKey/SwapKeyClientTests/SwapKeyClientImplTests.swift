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
        XCTAssertEqual(spy.receivedRequests.count, 1)
    }
    
    
    
}
