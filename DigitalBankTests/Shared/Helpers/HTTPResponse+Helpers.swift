//
//  HTTPResponse+Helpers.swift
//  DigitalBankTests
//
//  Created by Muhammad on 14/08/25.
//

import Foundation

enum HTTTPTest {
    static func response(
        url: URL,
        status: Int,
        headers: [String: String] = ["Content-Type": "application/json"]
    ) -> HTTPURLResponse {
        guard
            let http = HTTPURLResponse(
                url: url,
                statusCode: status,
                httpVersion: nil,
                headerFields: headers
            )
        else {
            fatalError("Invalid HTTPURLResponse for status \(status)")
        }
        return http
    }

}
