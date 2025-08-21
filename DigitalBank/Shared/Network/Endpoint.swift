//
//  Endpoint.swift
//  DigitalBank
//
//  Created by Muhammad on 21/08/25.
//
import Foundation

public protocol Endpoint {
    var url: URL { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
}

extension Endpoint {
    public var headers: [String: String] {
        [:]
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case head = "HEAD"
    case options = "OPTIONS"
    // CONNECT, TRACE — deyarli ishlatilmaydi, hozircha YAGNI
}
