//
//  SwapKeyClientImpl.swift
//  DigitalBank
//
//  Created by Muhammad on 11/08/25.
//

import Foundation

class SwapKeyClientImpl: SwapKeyClient {
    private let network: NetworkSession
    private let url: URL

    init(network: NetworkSession, url: URL) {
        self.network = network
        self.url = url
    }

    func send(request: SwapKeyModels.Request) async throws
        -> SwapKeyModels.Response
    {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        // Hozircha: JSONSerialization (YAGNI). Keyin RequestDTO ga o‘tamiz.
        let body = [
            "public_key1": request.public_key1,
            "public_key2": request.public_key2,
            "encryptData": request.encryptData,
            "device_code": request.device_code,
            "phone_nember": request.phoneNumber ?? "",
        ]
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body)

        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await network.data(for: urlRequest)
        } catch {
            throw NetworkError.transport(underlying: error)
        }

        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200...299).contains(http.statusCode) else {
            throw NetworkError.non2xx(status: http.statusCode)
        }

        do {
            let dto = try JSONDecoder().decode(
                SwapKeyDTO.Response.self,
                from: data
            )
            return dto.toDomain()
        } catch {
            throw NetworkError.decodingFailed(underlying: error)
        }

    }

}
