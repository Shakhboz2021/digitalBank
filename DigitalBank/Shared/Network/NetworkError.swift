//
//  NetworkError.swift
//  DigitalBank
//
//  Created by Muhammad on 14/08/25.
//

import Foundation

/// Umumiy network xatolari (OCP: keyin yangi case qo‘shish oson)
enum NetworkError: Error {
    case non2xx(status: Int, data: Data?)  // ⬅️ data qo‘shildi
    case decodingFailed(underlying: Error?)
    case transport(underlying: Error)
    case invalidResponse
    case invalidRequestURL
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .transport(let urlError as URLError):
            return urlError.localizedDescription  // offline, timeout va h.k.
        case .transport(let error):
            return error.localizedDescription

        case .invalidRequestURL:
            return "So‘rov URL noto‘g‘ri."

        case .invalidResponse:
            return "Server javobi noto‘g‘ri."

        case .decodingFailed:
            return "Ma’lumotni o‘qishda xatolik."

        case .non2xx(let status, let data):
            if let msg = Self.parseServerMessage(from: data) {
                return msg  // backenddan kelgan xabar
            }
            return "Server xatosi (\(status))."
        }
    }

    /// Backend body’dan xabarni ajratib olishga urinamiz
    private static func parseServerMessage(from data: Data?) -> String? {
        guard let data = data else { return nil }

        // 1) DTO ko‘rinishida kelishi mumkin
        struct APIErrorDTO: Decodable { let message: String? }
        if let dto = try? JSONDecoder().decode(APIErrorDTO.self, from: data),
            let msg = dto.message, !msg.isEmpty
        {
            return msg
        }

        // 2) Yoki oddiy JSON bo‘lishi mumkin
        if let obj = try? JSONSerialization.jsonObject(with: data)
            as? [String: Any]
        {
            for key in [
                "message", "msg", "error", "detail", "error_description",
            ] {
                if let s = obj[key] as? String, !s.isEmpty { return s }
            }
        }
        return nil
    }
}
