//
//  DIContainer.swift
//  DigitalBank
//
//  Created by Muhammad on 11/08/25.
//

import Foundation

final class DIContainer: ObservableObject {
    let auth: AuthAssembling
    init(auth: AuthAssembling = AuthAssembly()) {
        self.auth = auth
    }
}
