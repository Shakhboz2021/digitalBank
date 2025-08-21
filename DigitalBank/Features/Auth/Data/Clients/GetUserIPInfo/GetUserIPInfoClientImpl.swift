//
//  GetUserIPInfoClientImpl.swift
//  DigitalBank
//
//  Created by Muhammad on 12/08/25.
//
import Foundation

class GetUserIPInfoClientImpl: GetUserIPInfoClient {
    private let network: NetworkSession
    private let endpoint: Endpoint

    init(network: NetworkSession, endpoint: Endpoint) {
        self.network = network
        self.endpoint = endpoint
    }
    /// QUERY (CQS tamoyiliga ko‘ra: holatni o‘zgartirmaydi, faqat ma'lumot qaytaradi)
    func fetchUserIPInfo() async throws -> UserIPInfoDTO {
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers

        let (data, response) = try await network.data(for: request)
        guard let http = response as? HTTPURLResponse,
            (200..<300).contains(
                http.statusCode
            )
        else {
            throw URLError(.badServerResponse)
        }
        // YAGNI: maxsus decoder konfiguratsiyasini hozircha qo‘shmaymiz — kerak bo‘lsa keyin (OCP).
        return try JSONDecoder().decode(UserIPInfoDTO.self, from: data)
    }

}
