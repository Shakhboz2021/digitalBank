//
//  DIContainer.swift
//  DigitalBank
//
//  Created by Muhammad on 11/08/25.
//

import Foundation

final class DIContainer: ObservableObject {
    let auth: AuthAssembling
    let network: NetworkAssembling
    init(
        auth: AuthAssembling = AuthAssembly(),
        network: NetworkAssembling = NetworkAssembly()
    ) {
        self.auth = auth
        self.network = network
    }
}
