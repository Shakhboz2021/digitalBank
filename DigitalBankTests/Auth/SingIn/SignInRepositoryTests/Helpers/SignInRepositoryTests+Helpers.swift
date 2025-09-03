//
//  SignInRepositoryTests+Helpers.swift
//  DigitalBankTests
//
//  Created by Muhammad on 03/09/25.
//

import Foundation

@testable import DigitalBank

extension SignInRepositoryTests {
    func makeSUT(file: StaticString = #file, line: UInt = #line) -> (
        sut: SignInRepositoryImpl,
        client: SignInClientSpy
    ) {
        let client = SignInClientSpy()
        let sut = SignInRepositoryImpl(client: client)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(client, file: file, line: line)
        return (sut, client)
    }
    func makeDomainRequest() -> SignInModels.Request { .mock }
    func makeDTOResponse() -> SignInDTO.Response { .mock }
}
