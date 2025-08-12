//
//  UserIPInfo+Helpers.swift
//  DigitalBankTests
//
//  Created by Muhammad on 12/08/25.
//

import Foundation

@testable import DigitalBank

extension UserIPInfo {
    static var mock: Self {
        .init(
            status: "success",
            country: "Uzbekistan",
            countryCode: "UZ",
            region: "Toshkent",
            regionName: "Toshkent",
            city: "Tashkent",
            zip: "100000",
            lat: "41.3111",
            lon: "69.2797",
            timezone: "Asia/Tashkent",
            isp: "Uztelecom",
            org: "UZ",
            asNumber: "AS12345",
            query: "198.51.100.10",
            ip: "198.51.100.10"
        )
    }
}
