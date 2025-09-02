//
//  SignInRepository.swift
//  DigitalBank
//
//  Created by Muhammad on 02/09/25.
//

import Foundation

protocol SignInRepository {
    // Domain model bilan ishlaydi; transport/JSON detallaridan xoli.
    func check(request: SignInModels.Request) async throws -> SignInModels.Response
}
