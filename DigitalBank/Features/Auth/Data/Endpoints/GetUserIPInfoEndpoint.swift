//
//  GetUserIPInfoEndpoint.swift
//  DigitalBank
//
//  Created by Muhammad on 13/08/25.
//

import Foundation
enum GetUserIPInfoEndpoint {
    static var url: URL {
        URL(string: "https://requestid.universalbank.uz/api/request/identify/")!  
    }
}
