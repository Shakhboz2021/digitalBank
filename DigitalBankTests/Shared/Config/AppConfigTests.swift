//
//  AppConfigTests.swift
//  DigitalBankTests
//
//  Created by Muhammad on 04/09/25.
//

import Foundation
import XCTest

@testable import DigitalBank

final class AppConfigTests: XCTestCase {
    func test_baseURL_isValidInProduction() {
        // Arrange
        let url = AppConfig.baseURL

        // Assert
        XCTAssertTrue(
            url.absoluteString.hasPrefix("https"),
            "Expected https baseURL but got \(url)"
        )
    }
}
