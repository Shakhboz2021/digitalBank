//
//  UserIPInfoDTO.swift
//  DigitalBank
//
//  Created by Muhammad on 12/08/25.
//

import Foundation

struct UserIPInfoDTO: Decodable {
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
    let `as`: String?
    let query: String?
    let ip: String?
}
