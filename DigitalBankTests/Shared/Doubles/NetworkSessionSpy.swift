//
//  NetworkSessionSpy.swift
//  DigitalBankTests
//
//  Created by Muhammad on 13/08/25.
//

import Foundation

@testable import DigitalBank
final class NetworkSessionSpy: NetworkSession {
    private(set) var receivedRequests: [URLRequest] = []
    var result: Result<(Data, URLResponse), Error>?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        receivedRequests.append(request)
        guard let result else {
            throw URLError(.badServerResponse)
        }
        switch result {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }

}
