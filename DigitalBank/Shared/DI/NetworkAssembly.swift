//
//  NetworkAssembly.swift
//  DigitalBank
//
//  Created by Muhammad on 13/08/25.
//

import Foundation

    /// SRP: faqat Network qatlamini yig‘ish vazifasi.
    /// DIP: `NetworkSession` protokolini qaytaradi, implement tafsilot yashiriladi.
protocol NetworkAssembling {
    func makeNetworkSession() -> NetworkSession
}

    /// Prod implementatsiya: Default network stack bilan ishlaydi
final class NetworkAssembly: NetworkAssembling {
    func makeNetworkSession() -> NetworkSession {
        DefaultNetworkSession()
    }
}
