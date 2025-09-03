//
//  SignInRepositoryTests+Helpers.swift
//  DigitalBankTests
//
//  Created by Muhammad on 03/09/25.
//

import Foundation

@testable import DigitalBank

extension SignInRepositoryTests {
    func makeSUT() -> (sut: SignInRepository, client: SignInClient) {
        let client = SignInClientSpy()
        let sut = SignInRepositoryImpl(client: client)
        return (sut, client)
    }
    func makeDomainRequest() -> SignInModels.Request { .mock }
    func makeDTOResponse() -> SignInDTO.Response { .mock }
}
