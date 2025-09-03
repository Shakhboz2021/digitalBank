//
//  SignInUseCaseTest+Helpers.swift
//  DigitalBankTests
//
//  Created by Muhammad on 02/09/25.
//

import Foundation

@testable import DigitalBank

extension SignInUseCaseTests {
    func makeSUT() -> (sut: SignInUseCaseImpl, repository: SignInRepositorySpy)
    {
        let repo = SignInRepositorySpy()
        let sut = SignInUseCaseImpl(repository: repo)
        return (sut, repo)
    }
}
