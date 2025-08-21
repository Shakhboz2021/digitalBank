//
//  JSONCoder.swift
//  DigitalBank
//
//  Created by Muhammad on 21/08/25.
//

import Foundation

enum JSONCoder {
    static func makeEncoder() -> JSONEncoder {
        let enc = JSONEncoder()
        // Server naming policy: kerak bo‘lsa yoqing
        // enc.keyEncodingStrategy = .convertToSnakeCase
        enc.dateEncodingStrategy = .iso8601
        enc.outputFormatting = []  // .sortedKeys yoki .prettyPrinted kerak bo‘lsa testlarda
        return enc
    }

    static func makeDecoder() -> JSONDecoder {
        let dec = JSONDecoder()
        // Server naming policy: kerak bo‘lsa yoqing
        // dec.keyDecodingStrategy = .convertFromSnakeCase
        dec.dateDecodingStrategy = .iso8601
        return dec
    }
}
