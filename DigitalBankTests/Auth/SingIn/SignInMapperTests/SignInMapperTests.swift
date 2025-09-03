//
//  SignInMapperTests.swift
//  DigitalBankTests
//
//  Created by Muhammad on 03/09/25.
//

import Foundation
import XCTest

@testable import DigitalBank

final class SignInMapperTests: XCTestCase {
    func test_request_toDTO_preservesAllFields() {
        // Arrange
        let domainRequest: SignInModels.Request = .mock

        // Act
        let dto = domainRequest.toDTO()

        // Assert
        XCTAssertEqual(dto.clientId, domainRequest.clientId)
        XCTAssertEqual(dto.phoneNumber, domainRequest.phoneNumber)
        XCTAssertEqual(dto.deviceType, domainRequest.deviceType)
        XCTAssertEqual(dto.deviceCode, domainRequest.deviceCode)
        XCTAssertEqual(dto.deviceName, domainRequest.deviceName)
        XCTAssertEqual(dto.version, domainRequest.version)
        XCTAssertEqual(dto.password, domainRequest.password)
        XCTAssertEqual(dto.isPin, domainRequest.isPin)
        XCTAssertEqual(dto.appVersionCode, domainRequest.appVersionCode)
        XCTAssertEqual(dto.osVersion, domainRequest.osVersion)
        XCTAssertEqual(dto.appVersion, domainRequest.appVersion)
        XCTAssertEqual(dto.osSystemVersionApi, domainRequest.osSystemVersionApi)
        XCTAssertEqual(dto.userInfo, domainRequest.userInfo.toDTO())
    }

    func test_response_toDomain_preservesAllFields() {
        //Arrange
        let dtoResponse: SignInDTO.Response = .mock
        //Act
        let domain = dtoResponse.toDomain()

        // Assert
        XCTAssertEqual(domain.code, dtoResponse.code)
        XCTAssertEqual(domain.message, dtoResponse.message)
        XCTAssertEqual(domain.stringLine, dtoResponse.stringLine)
        XCTAssertEqual(domain.deviceMyIdState, dtoResponse.deviceMyIdState)
    }
}
