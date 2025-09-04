//
//  HTTPResponse+Helpers.swift
//  DigitalBankTests
//
//  Created by Muhammad on 14/08/25.
//

import Foundation

@testable import DigitalBank

enum HTTPTest {
    static func response(
        endpoint: Endpoint,
        status: Int
    ) -> HTTPURLResponse {
        guard
            let http = HTTPURLResponse(
                url: endpoint.url,
                statusCode: status,
                httpVersion: nil,
                headerFields: endpoint.headers
            )
        else {
            fatalError("Invalid HTTPURLResponse for status \(status)")
        }
        return http
    }

}
