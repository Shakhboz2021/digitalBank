//
//  GetUserIPInfoClientImpl.swift
//  DigitalBank
//
//  Created by Muhammad on 12/08/25.
//
import Foundation

class GetUserIPInfoClientImpl: GetUserIPInfoClient {
    private let network: NetworkSession
    private let url: URL

    init(network: NetworkSession, url: URL) {
        self.network = network
        self.url = url
    }
    /// QUERY (CQS tamoyiliga ko‘ra: holatni o‘zgartirmaydi, faqat ma'lumot qaytaradi)
    func fetchUserIPInfo() async throws -> UserIPInfoDTO {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")

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
