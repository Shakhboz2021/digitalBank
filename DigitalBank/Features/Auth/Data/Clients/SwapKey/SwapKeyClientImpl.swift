//
//  SwapKeyClientImpl.swift
//  DigitalBank
//
//  Created by Muhammad on 11/08/25.
//

import Foundation

class SwapKeyClientImpl: SwapKeyClient {
    private let session: URLSession
    private let url: URL

    init(session: URLSession = .shared, url: URL) {
        self.session = session
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

        let body = [
            "public_key1": request.public_key1,
            "public_key2": request.public_key2,
            "encryptData": request.encryptData,
            "device_code": request.device_code,
            "phone_nember": request.phoneNumber ?? "",
        ]

        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body)
        let (data, response) = try await session.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse,
            (200..<300).contains(httpResponse.statusCode)
        else {
            throw URLError(.badServerResponse)
        }
        let decoded = try JSONDecoder().decode(
            SwapKeyDTO.Response.self,
            from: data
        )

        return decoded.toDomain()

    }

}
