//
//  Endpoint.swift
//  DigitalBank
//
//  Created by Muhammad on 21/08/25.
//
import Foundation

protocol Endpoint {
    var url: URL { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var query: [URLQueryItem] { get }
}

extension Endpoint {
    public var headers: [String: String] {
        [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "lang": "RU",
            "Authorization": "KeychainAccess.getKey(key: .token)",
            "devicecode": "getDeviceID()",
            "device": "I",
        ]
    }
    var query: [URLQueryItem] { [] }

    func makeRequest(
        body: Encodable?,
        encoder: JSONEncoder = JSONCoder.makeEncoder()
    ) throws
        -> URLRequest
    {
        var components = URLComponents(
            url: url,
            resolvingAgainstBaseURL: false
        )!
        if !query.isEmpty {
            components.queryItems = query
        }
        var req = URLRequest(url: components.url!)
        req.httpMethod = method.rawValue
        headers.forEach { req.setValue($1, forHTTPHeaderField: $0) }
        if let body {
            req.httpBody = try encoder.encode(AnyEncodable(body))
        }
        if req.value(forHTTPHeaderField: "Content-Type") == nil {
            req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return req
    }
}
/// Kichik helper – Encodable'ni erased qilish uchun
private struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void
    init(_ base: Encodable) { _encode = base.encode }
    func encode(to encoder: Encoder) throws { try _encode(encoder) }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case head = "HEAD"
    case options = "OPTIONS"
    // CONNECT, TRACE — deyarli ishlatilmaydi, hozircha YAGNI
}
