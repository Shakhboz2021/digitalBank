//
//  NetworkSession.swift
//  DigitalBank
//
//  Created by Muhammad on 13/08/25.
//

import Foundation

/// CQS: faqat "query" (data(for:)) ni taqdim etamiz.
/// DIP/LoD: Client'lar URLSession tafsilotlarini bilmaydi.
protocol NetworkSession {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

/// Prod implementatsiya: Default network session konfiguratsiyasi
/// SRP: faqat URLSession orqali so‘rov yuborish vazifasi.
final class DefaultNetworkSession: NetworkSession {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await session.data(for: request)
    }

}
