//
//  SignInClientImpl.swift
//  DigitalBank
//
//  Created by Muhammad on 04/09/25.
//

import Foundation

class SignInClientImpl: SignInClient {
    private let network: NetworkSession
    private let endpoint: Endpoint

    init(network: NetworkSession, endpoint: Endpoint) {
        self.network = network
        self.endpoint = endpoint
    }

    func signIn(request: SignInDTO.Request) async throws -> SignInDTO.Response {

        let urlRequest = try endpoint.makeRequest()

        let (data, response) = try await network.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200...300).contains(httpResponse.statusCode) else {
            throw NetworkError.non2xx(status: httpResponse.statusCode)
        }

        return try JSONDecoder().decode(SignInDTO.Response.self, from: data)

    }

}
