//
//  SignInUseCaseTest+Helpers.swift
//  DigitalBankTests
//
//  Created by Muhammad on 02/09/25.
//

import Foundation

@testable import DigitalBank

extension SignInUseCaseTests {
    func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (
        sut: SignInUseCaseImpl, repository: SignInRepositorySpy
    ) {
        let repo = SignInRepositorySpy()
        let sut = SignInUseCaseImpl(repository: repo)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(repo, file: file, line: line)
        return (sut, repo)
    }
}
