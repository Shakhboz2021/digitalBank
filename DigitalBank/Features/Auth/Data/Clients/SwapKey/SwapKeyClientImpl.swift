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
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    init(
        network: NetworkSession,
        url: URL,
        encoder: JSONEncoder = .init(),
        decoder: JSONDecoder = .init()
    ) {
        self.network = network
        self.url = url
        self.encoder = encoder
        self.decoder = decoder
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

        let requestDTO = SwapKeyDTO.Request(domain: request)
        urlRequest.httpBody = try encoder.encode(requestDTO)

        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await network.data(for: urlRequest)
        } catch {
            throw mapTransportError(error)
        }

        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200...299).contains(http.statusCode) else {
            throw NetworkError.non2xx(status: http.statusCode)
        }

        do {
            let dto = try decoder.decode(
                SwapKeyDTO.Response.self,
                from: data
            )
            return dto.toDomain()
        } catch {
            throw NetworkError.decodingFailed(underlying: error)
        }

    }

    // MARK: - Error mapping SRP/OCP
    func mapTransportError(_ error: Error) -> NetworkError {
        // Hozircha barcha URLSession xatolarini transport sifatida o'raymiz.
        // Keyin kerak bo'lsa URLError.Code bo'yicha case-by-case map qilamiz (OCP).
        NetworkError.transport(underlying: error)
    }

}
