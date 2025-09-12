//
//  UserIPInfo.swift
//  DigitalBank
//
//  Created by Muhammad on 12/08/25.
//

import Foundation

/// Domain model for user's network/IP info (Swift-friendly, backend-agnostic)
struct UserIPInfo: Equatable {
    let status: String?
    let country: String?
    let countryCode: String?
    let region: String?
    let regionName: String?
    let city: String?
    let zip: String?
    let lat: String?
    let lon: String?
    let timezone: String?
    let isp: String?
    let org: String?
    let asNumber: String?  // backend `as` -> domain-friendly name
    let query: String?
    let ip: String?

    static var mock: Self {
        .init(
            status: nil,
            country: nil,
            countryCode: nil,
            region: nil,
            regionName: nil,
            city: nil,
            zip: nil,
            lat: nil,
            lon: nil,
            timezone: nil,
            isp: nil,
            org: nil,
            asNumber: nil,
            query: nil,
            ip: nil
        )
    }
}
