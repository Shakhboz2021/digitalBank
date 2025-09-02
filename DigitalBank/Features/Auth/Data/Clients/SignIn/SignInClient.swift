//
//  SignInClient.swift
//  DigitalBank
//
//  Created by Muhammad on 02/09/25.
//

import Foundation

protocol SignInClient {
    func check(request: SignInDTO.Request) async throws -> SignInDTO.Response
}
