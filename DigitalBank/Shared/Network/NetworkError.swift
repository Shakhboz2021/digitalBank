//
//  NetworkError.swift
//  DigitalBank
//
//  Created by Muhammad on 14/08/25.
//

import Foundation

/// Umumiy network xatolari (OCP: keyin yangi case qo‘shish oson)
enum NetworkError: Error {
    case non2xx(status: Int)
    case decodingFailed(underlying: Error?)
    case transport(underlying: Error)
    case invalidREsponse
}
