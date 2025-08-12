//
//  UserIPInfoMapper.swift
//  DigitalBank
//
//  Created by Muhammad on 12/08/25.
//

import Foundation

extension UserIPInfoDTO {
    func toDomain() -> UserIPInfo {
        UserIPInfo(
            status: status,
            country: country,
            countryCode: countryCode,
            region: region,
            regionName: regionName,
            city: city,
            zip: zip,
            lat: lat,
            lon: lon,
            timezone: timezone,
            isp: isp,
            org: org,
            asNumber: `as`,
            query: query,
            ip: ip ?? query  // ba'zi servislar ip o‘rniga query qaytaradi,
        )
    }
}
